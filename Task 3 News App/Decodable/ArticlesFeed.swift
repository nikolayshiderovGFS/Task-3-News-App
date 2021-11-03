//
//  ArticlesFeed.swift
//  Task 3 News App
//
//  Created by Nikolay Shiderov on 2.11.21.
//

import Foundation

struct ArticlesFeed: Decodable {
    var status: String
    var totalResults: Int = 0
    var articles: [Article]?
}
