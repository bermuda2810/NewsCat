//
//  NewsManager.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/13/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation

protocol NewsDelegate {
    func onNewsRecevied(news : [News])
    func onError(message : String)
}

struct NewsManager {
    var delegate : NewsDelegate? = nil
    
    var closure = ((news : [News]) -> Void).self
    
    func funcName(param : String) -> Void {
        
    }
    
    public func fetchNews() {
        DispatchQueue.global(qos: .background).async {
            let data = self.fetchNewsFromCloud()
            DispatchQueue.main.sync {
                self.delegate?.onNewsRecevied(news: data)
            }
        }
    }
    
    public func fetchNews1(completion: @escaping (_ news : [News]) -> Void){
        print("Will load data from bg Thread")
        var news : Array = [News]()
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            print("Im fetching data from bg Thread")
            for i in 0...2 {
                var itemNews = News()
                itemNews.title = "Title \(i + 1)"
                itemNews.desc = "Desc \(i + 1)"
                news.append(itemNews)
            }
            self.fetchNewsFromCloud()
            DispatchQueue.main.sync {
                completion(news)
//                let instance = target as! NSObject
//                instance.perform(selector, with: news)
            }
        }
        print("I will finish method fetchNews")
    }
    
    
    private func fetchNewsFromCloud() -> [News]{
        var request = URLRequest(url: URL(string: "http://thanoss.com/api/v1/news")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("bounty_hunter_202@", forHTTPHeaderField: "secret-key")
    
        let session = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if (error == nil && data != nil) {
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                print("Response data \(responseData!)")
            }else {
                print("Something went wrong")
            }
        })
        session.resume()
        return []
    }
    
    public func login(username : String, pass : String, completion : @escaping (_ result : Bool, _ message : String) -> Void) {
        completion(true, "Ok Im fine")
    }
}
