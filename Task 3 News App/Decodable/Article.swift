//
//  Article.swift
//  Task 3 News App
//
//  Created by Nikolay Shiderov on 2.11.21.
//

import Foundation

struct Article: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
