//
//  News.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

class News: Codable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    var numberOfShowes: Int?
    var stringShowes: String?
    
    func setNum() {
        if numberOfShowes == nil {
            numberOfShowes = 0
        }
    }
    
    func addShow() {
        numberOfShowes! += 1
    }
}

struct NewsPack: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}
