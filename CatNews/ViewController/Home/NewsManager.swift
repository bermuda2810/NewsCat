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
    
    var completion: ((_ news : [News]) -> Void)? = nil
    
    func funcName(param : String) -> Void {
        
    }
    
    public func fetchNews() {
        DispatchQueue.global(qos: .background).async {
            self.fetchNewsFromCloud()
        }
    }
    
    public func requestCompletion(data : Data?, response : URLResponse? , error : Error?) {
        if ((error) != nil) {
            notifyError(message: error?.localizedDescription ?? "Unknown error")
            return
        }
        
        if (data == nil) {
            notifyError(message: "Data is nil")
            return
        }
        
        let newsData = try? JSONDecoder.init().decode(ResponseData.self, from: data!)
        print("Hello")
        
        
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
        let code = json?.value(forKey: "code") as! Int
        
        if code != self.REQUEST_OK {
            let message = json?.safeValueFor(key: "message", defaultValue: "Something wrong Server")
            notifyError(message: message as! String)
            return
        }
        
        var result = Array<News>()
        let jArrayNews = json?.safeValueFor(key: "data", defaultValue: []) as! Array<NSDictionary>
        
        for jNews in jArrayNews {
            let news = parseNews(jNews: jNews)
            result.append(news)
        }
        DispatchQueue.main.sync {
            self.delegate?.onNewsRecevied(news: result)
        }
    }
    
    private func parseNews(jNews  : NSDictionary) -> News {
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
        return news
    }
    
    private func notifyError(message : String) {
        DispatchQueue.main.sync {
            self.delegate?.onError(message: message)
        }
    }

    
    private func fetchNewsFromCloud() {
        var request = URLRequest(url: URL(string: "http://thanoss.com/api/v1/news")!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("bounty_hunter_202@", forHTTPHeaderField: "secret-key")
        let session = URLSession.shared.dataTask(with: request, completionHandler: requestCompletion(data:response:error:))
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
