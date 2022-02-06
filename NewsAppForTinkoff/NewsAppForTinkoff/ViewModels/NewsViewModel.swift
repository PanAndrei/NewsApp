//
//  NewsViewModel.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

struct NewsViewModel {
    
    
    var news: News
    
    // кэширование в юзердефолтс ?
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
    
    // картинка из установки
    var urlToImage: String {
//        return news.urlToImage ?? "https://img2.freepng.ru/20180609/guv/kisspng-92-news-newspaper-live-television-express-news-5b1b6ba7a245d3.1810649915285236876647.jpg"
        
        return (news.urlToImage) ?? ""
        
    }
    
    var numberOfShowes: Int {
        return news.numberOfShowes!
    }
    
    func addShow()  {
        news.addShow()
    }
    
    var stringShowes: String {
        news.setNum()
        if news.numberOfShowes == 1 {
            return "It was shown \(news.numberOfShowes!) time"
        } else {
            return "It was shown \(news.numberOfShowes!) times"
        }
    }
    
}
