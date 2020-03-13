//
//  NewsManager.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/13/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation

struct NewsManager {
    
    public func fetchNews() -> [News] {
        var news : Array = [News]()
        for i in 0...2 {
            var itemNews = News()
            itemNews.title = "Title \(i + 1)"
            itemNews.desc = "Desc \(i + 1)"
            news.append(itemNews)
        }
        return news
    }
}
