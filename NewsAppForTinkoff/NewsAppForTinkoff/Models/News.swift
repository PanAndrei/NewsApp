//
//  News.swift
//  NewsAppForTinkoff
//
//  Created by Andrei Panasenko on 05.02.2022.
//

import Foundation

struct News: Decodable {
    // автор или ID новости для идентификации - а бывает что айди и нет
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    // картинка на случай отсутствия интернета
    let url: String?
}

// 20 news
struct NewsPack: Decodable {
    let status: String
    let totalResults: Int
    let articles: [News]
}
