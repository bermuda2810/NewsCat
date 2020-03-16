//
//  NewsManager.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/13/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation

struct NewsManager {
    
    var closure = ((news : [News]) -> Void).self
    
    public func fetchNews(completion: @escaping (_ news : [News]) -> Void){
        print("Will load data from bg Thread")
        var news : Array = [News]()
        DispatchQueue.global(qos: .background).async {
            sleep(5)
            print("Im fetching data from bg Thread")
            for i in 0...2 {
                var itemNews = News()
                itemNews.title = "Title \(i + 1)"
                itemNews.desc = "Desc \(i + 1)"
                news.append(itemNews)
            }
            DispatchQueue.main.sync {
                completion(news)
//                let instance = target as! NSObject
//                instance.perform(selector, with: news)
            }
        }
        print("I will finish method fetchNews")
    }
    
    public func login(username : String, pass : String, completion : @escaping (_ result : Bool, _ message : String) -> Void) {
        completion(true, "Ok Im fine")
    }
}
