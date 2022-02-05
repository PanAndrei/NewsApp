//
//  NetworkManager.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

class NetworkManager {
    // кэшированик картинок
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {}
    
    // base url
    private let baseURLString = "https://newsapi.org/v2/"
    // for choose type
    private let USTopHeadline = "top-headlines?country=us"
    
    // escaping
    // отсюда вернуть кэшированные новости если нет интернета или первое соединение
    // вот тут добавить возможность выбора из категории новостей
    func getNews(completion: @escaping ([News]?) -> Void) {
        let urlString = "\(baseURLString)\(USTopHeadline)&apiKey=\(APIKey.key)"
        guard let url = URL(string: urlString) else {
            return
            // from cache
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                // обработка ошибок может тут уведомление
                print("the error is \(error?.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                // cache
                completion(nil)
                return
            }
            
            let newsPack = try? JSONDecoder().decode(NewsPack.self, from: data)
            newsPack == nil ? completion(nil) : completion(newsPack!.articles)
        }.resume()
    }
}