//
//  NewsListViewModel.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

// кэширование
// выбор изображение - tableView or collectionView
class NewsListViewModel {
    var newsVM = [NewsViewModel]()
    
    let reuseID = "news"
    
    func getNews(completion: @escaping ([NewsViewModel]) -> Void) {
        NetworkManager.shared.getNews { (news) in
            guard let news = news else {
                // показать кэщ
                return
            }
            let newsVM = news.map(NewsViewModel.init)
            // async для загрузки
            // постраничная загрузка?
            DispatchQueue.main.async {
                self.newsVM = newsVM
                completion(newsVM)
            }
        }
    }
}
