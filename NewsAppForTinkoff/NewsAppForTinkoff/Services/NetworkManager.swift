//
//  NetworkManager.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

class NetworkManager {
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private let baseURLString = "https://newsapi.org/v2/"
    private let USTopHeadline = "everything?q=apple&from=2022-02-05&to=2022-02-05&sortBy=popularity"

    private let numberOfNewInPage = 20
    static var currentPage = 1
    
    init() {}

    func getNews(completion: @escaping ([News]?) -> Void) {
        var urlString = "\(baseURLString)\(USTopHeadline)&apiKey=\(APIKey.key)&pageSize=\(numberOfNewInPage)&page=\(NetworkManager.currentPage)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("the error is \(error?.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }

            let newsPack = try? JSONDecoder().decode(NewsPack.self, from: data)
            newsPack == nil ? completion(nil) : completion(newsPack!.articles)
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString ) else {
            completion(nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    completion(nil)
                    return
                }
                guard let data = data else {
                    completion(nil)
                    return
                }
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
    
    func nextPage() {
        NetworkManager.currentPage += 1
        print("current page is \(NetworkManager.currentPage)")
    }
}
