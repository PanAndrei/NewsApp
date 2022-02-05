//
//  ViewController.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 04.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // из кэша
        NetworkManager.shared.getNews { (news) in
            guard let news = news else { return }
        }
    }


}

