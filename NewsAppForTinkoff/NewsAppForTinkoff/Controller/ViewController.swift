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
    ///
    var refreshControl: UIRefreshControl!
    
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
    
    //
//    override func loadView() {
//        super.loadView()
//        viewModel.saveInUD()
//    }
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchNews()
        
        //
        fetchNews()
        //
        
        setupRefresh()
        //
        
//        setButtonRefresh()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(tableView)
        //
//        view.addSubview(setButtonRefresh())
        
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
        }
//        viewModel.saveInUD()
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
    
    //
//    func setButtonRefresh() {
//         lazy var buttonRefresh: UIButton = {
//            let button = UIButton()
//            button.translatesAutoresizingMaskIntoConstraints = false
//             let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
//            button.setImage(UIImage(systemName: "goforward", withConfiguration: config)?.withRenderingMode(.alwaysOriginal), for: .normal)
//            button.contentMode = .scaleAspectFit
//    //
//            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//            return button
//        }()
//    }
//
//    @objc func buttonAction(_ sender: UIButton!) {
//         print("button pressed")
//     }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 20 news
        viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        // достатть из кэша
        
        //
        
//        viewModel.loadFromUD()
        
        // работает но счетчик на ноль сбрасывает
//        viewModel.loadFromUD()
        let news = viewModel.newsVM[indexPath.row]
        
        //
        
        
        //
        
//        var newsArr = viewModel.newsVM
//        var news = viewModel.newsVM[indexPath.row]
////
//        if newsArr.isEmpty {
//            let news = viewModel.newsVM[indexPath.row]
//            viewModel.saveInUD()
//        } else {
//            viewModel.loadFromUD()
//            let news = viewModel.newsVM[indexPath.row]
//        }
        //
        
//        let news = viewModel.newsVM[0]
        cell?.newsVM = news
        return cell ?? UITableViewCell()
        // костыль
//        return indexPath.row < 21 ? cell ?? UITableViewCell() : UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsVM[indexPath.row]
        guard let url = URL(string: news.url) else {
            // добавить кэш
            return
        }
        
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        // or .formScreen
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
        
        viewModel.newsVM[indexPath.row].addShow()
        reloadInputViews()
        
    }
    
}


