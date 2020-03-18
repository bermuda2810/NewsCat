//
//  NewsHeaderView.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/18/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation
import UIKit

class NewsHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    func bindData(_ title1 : String, _ title2 : String, _ section : Int) {
        if (section == 0) {
            lbl1.text = title1
            lbl2.text = title2
        }else {
            lbl1.text = ""
            lbl2.text = ""
        }
    }
}
