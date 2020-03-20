//
//  ViewController.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/3/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewsDelegate {
    
    @IBOutlet weak var tblNews: UITableView!
    private var test : String?
    private var numberOfRows : Int = -1
    private var news : Array = [News]()
    private var newManager : NewsManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib.init(nibName: "NewsHeaderView", bundle: Bundle.main)
        tblNews.register(headerNib, forHeaderFooterViewReuseIdentifier: "NewsHeaderView")

        
        let footerNib = UINib.init(nibName: "NewsSeparatorView", bundle: Bundle.main)
        tblNews.register(footerNib, forHeaderFooterViewReuseIdentifier: "NewsSeparatorView")

        
        newManager = NewsManager()
        newManager?.delegate = self
//        newManager?.fetchNews(target: self, selector: #selector(onDataReceived))
        newManager?.fetchNews()
//        newManager?.login(username: "abc", pass: "1234", completion: { (result, message) in
            
//        })
        tblNews.dataSource = self
        tblNews.delegate = self
        print("viewDidLoad finished")
    }
    
    
    func onNewsRecevied(news: [News]) {
        print("Ok I got \(news.count) items")
               self.news = news as! [News]
               self.tblNews.reloadData()
    }
    
    func onError(message: String) {
        
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
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsHeaderView") as! NewsHeaderView
        headerView.bindData("Cat", "Dog", section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NewsSeparatorView") as! NewsSeparatorView
        if section == 0 {
            footerView.cstLineHeight.constant = 0.5
        }else {
            footerView.cstLineHeight.constant = 0.0
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }else {
            return news.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsIdentifier") as! NewsCell
        let data = self.news[indexPath.row]
        cell.bindData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 120.0
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50.0
        }
        return 0.001
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
        
    @IBAction func showListPressed(_ sender: Any) {
        numberOfRows = 10
        tblNews.reloadData()
    }
}

