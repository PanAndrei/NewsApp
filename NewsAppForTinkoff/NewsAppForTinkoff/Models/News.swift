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
    var numberOfShowes = 0

    var stringShowes: String?
    
    func addShow() {
        numberOfShowes += 1
    }
}

struct NewsPack: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}
