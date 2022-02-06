//
//  ViewController.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 04.02.2022.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var viewModel = NewsListViewModel()
    var networkManager = NetworkManager()
    var refreshControl: UIRefreshControl!
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("news.plist")
    
    private lazy var headerView: HeaderView = {
        let v = HeaderView(fontSize: 32)
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.tableFooterView = UIView()
        v.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchNews()
        setupRefresh()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFromUD()
        tableView.reloadData()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // header
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        // tableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchNews() {
        viewModel.getNews { (_) in
            self.tableView.reloadData()
            self.saveInUD()
        }
    }
    
    func setupRefresh() {
        refreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                                        #selector(ViewController.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.red

            return refreshControl
        }()
        refreshControl.attributedTitle = NSAttributedString(string: "reload")
        tableView.addSubview(refreshControl)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        networkManager.nextPage()
        fetchNews()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        let news = viewModel.newsVM[indexPath.row]
        
        cell?.newsVM = news
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsVM[indexPath.row]
        guard let url = URL(string: news.url) else {
            return
        }
        
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
        
        viewModel.newsVM[indexPath.row].addShow()
        saveInUD()
        reloadInputViews()
        
    }
}

extension ViewController {
    
    func saveInUD() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(viewModel.newsVM)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding \(error)")
        }
        print("data saved")
    }
    
    func loadFromUD() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                viewModel.newsVM = try decoder.decode([NewsViewModel].self, from: data)
            } catch {
                print("error was \(error)")
            }
        }
    }
}
