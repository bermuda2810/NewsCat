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
    
    let REQUEST_OK = 200
    
    func funcName(param : String) -> Void {
        
    }
    
    public func fetchNews() {
        DispatchQueue.global(qos: .background).async {
            self.fetchNewsFromCloud { (data) in
                DispatchQueue.main.sync {
                    self.delegate?.onNewsRecevied(news: data)
                }
            }
        }
    }

    
    private func fetchNewsFromCloud(completion: @escaping (_ news : [News]) -> Void) {
        var request = URLRequest(url: URL(string: "http://thanoss.com/api/v1/news")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("bounty_hunter_202@", forHTTPHeaderField: "secret-key")
    
        let session = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if (error == nil && data != nil) {
                let response = String(data: data!, encoding: String.Encoding.utf8)!
                let data = Data(response.utf8)
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                let code = json?.value(forKey: "code") as! Int
                if code == self.REQUEST_OK {
                    var result = Array<News>()
                    let jArrayNews = json?.value(forKey: "data") as! Array<NSDictionary>
                    for jNews in jArrayNews {
                        let title = jNews.safeValueFor(key: "title", defaultValue: "")
                        let desc = jNews.safeValueFor(key: "desc", defaultValue: "")
                        let imageUrl = jNews.safeValueFor(key: "image_url", defaultValue: "")
                        let timestamp = jNews.safeValueFor(key: "timestamp", defaultValue: "") as! String
                        
                        var news = News()
                        news.title = title as! String
                        news.desc = desc as! String
                        news.imageUrl = imageUrl as! String
                        news.time = timestamp.getHour()
                        news.date = timestamp.getShortDate()
                        result.append(news)
                    }
                    completion(result)
                }else {
                    completion([])
                }
            }else {
                completion([])
            }
        })
        session.resume()
    }
    
    private func safeValueFor(data : NSDictionary, key : String, defaultValue : Any) -> Any {
        if let jValue = data.value(forKey: key){
            return jValue
        }
        return defaultValue
    }
    
    public func login(username : String, pass : String, completion : @escaping (_ result : Bool, _ message : String) -> Void) {
        completion(true, "Ok Im fine")
    }
}
