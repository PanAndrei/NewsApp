//
//  NewsViewModel.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

struct NewsViewModel: Codable {
    
    var news: News
    
    var author: String {
        return news.author ?? "Unknown author"
    }
    
    var title: String {
        return news.title ?? "Unknown title"
    }
    
    var description: String {
        return news.description ?? "Unknown description"
    }
    
    var url: String {
        return news.url ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage ?? "https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX7434421.jpg" 
    }
    
    var numberOfShowes: Int {
        return news.numberOfShowes
    }
    
    var stringShowes: String {
        if news.numberOfShowes == 1 {
            return "It was shown \(news.numberOfShowes) time"
        } else {
            return "It was shown \(news.numberOfShowes) times"
        }
    }
    
    func addShow()  {
        news.addShow()
    }
}


