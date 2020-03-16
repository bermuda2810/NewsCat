//
//  ViewController.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/3/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblNews: UITableView!
    private var test : String?
    private var numberOfRows : Int = -1
    private var news : Array = [News]()
    private var newManager : NewsManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newManager = NewsManager()
//        newManager?.fetchNews(target: self, selector: #selector(onDataReceived))
        newManager?.fetchNews(completion: { (news : [News]) in
            self.onFetched(news)
        })
        newManager?.login(username: "abc", pass: "1234", completion: { (result, message) in
            
        })
        tblNews.dataSource = self
        tblNews.delegate = self
    }
    
    private func onFetched(_ news : Array<News>) {
        self.news = news
        self.tblNews.reloadData()
    }
    
    @objc func onDataReceived(_ news : Array<Any>) {
        print("Ok I got \(news.count) items")
        self.news = news as! [News]
        self.tblNews.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsIdentifier") as! NewsCell
        let data = self.news[indexPath.row]
        cell.bindData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
        
    @IBAction func showListPressed(_ sender: Any) {
        numberOfRows = 10
        tblNews.reloadData()
    }
}

