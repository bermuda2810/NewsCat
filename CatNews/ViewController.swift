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
    private var numberOfRows : Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNews.dataSource = self
        tblNews.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsIdentifier")!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }

    
    @IBAction func showListPressed(_ sender: Any) {
        numberOfRows = 3
        tblNews.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("Cell at \(indexPath.section) row at \(indexPath.row)")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "IdentifierNews") as! NewsCell
//        cell.lblTitle.text = "ABC"
//        return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }


}

