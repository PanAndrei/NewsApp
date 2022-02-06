//
//  News.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

//struct News: Decodable {
class News: Codable {
    // автор или ID новости для идентификации - а бывает что айди и нет
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    
    // showes
    
    var numberOfShowes: Int?
    
    var stringShowes: String?
    
    func setNum() {
        if numberOfShowes == nil {
            numberOfShowes = 0
        } 
        
//        numberOfShowes =
    }
    
    func addShow() {
        numberOfShowes! += 1
        
        print("was shown \(numberOfShowes)")
    }
    
}

// 20 news
struct NewsPack: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}
