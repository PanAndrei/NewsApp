//
//  NewsListViewModel.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

// кэширование
// выбор изображение - tableView or collectionView


//

let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("news.plist")

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
            //
            //
            self.saveInUD()
            // async для загрузки
            // постраничная загрузка?
            DispatchQueue.main.async {
                self.newsVM = newsVM
                completion(newsVM)
            }
        }
    }
    
    ///@IBAction func
    ///@IBAction func

    func saveInUD() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(newsVM)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding \(error)")
        }
        
        print(dataFilePath)
    }
    
    func loadFromUD() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                newsVM = try decoder.decode([NewsViewModel].self, from: data)
            } catch {
                print("error was \(error)")
            }
        }
    }
  
}
