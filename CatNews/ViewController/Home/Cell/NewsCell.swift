//
//  NewsCell.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/9/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cardView: UIView!
    private var didInitialedView : Bool = false
    @IBOutlet weak var imgNews: UIImageView!
    
    
    func bindData(_ news : News) {
        roundCardView()
        roundImage()
        lblTitle.text = news.title
        lblDesc.text = news.desc
    }
    
    private func roundCardView() {
//        let rectShape = CAShapeLayer()
//        rectShape.bounds = self.cardView.frame
//        rectShape.position = self.cardView.center
//        rectShape.path = UIBezierPath(roundedRect: self.cardView.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .topRight , .bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
//        self.cardView.layer.mask = rectShape
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOpacity = 0.75
        cardView.layer.shadowRadius = 5.0
        cardView.layer.shadowOffset = CGSize.init(width: 2.0, height: 2.0)
        cardView.layer.masksToBounds = false
    }
    
    private func roundImage() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.imgNews.frame
        rectShape.position = self.imgNews.center
        rectShape.path = UIBezierPath(roundedRect: self.imgNews.bounds, byRoundingCorners: [.bottomLeft , .topLeft], cornerRadii: CGSize(width: 10.0, height: 10.0)).cgPath
            self.imgNews.layer.mask = rectShape
    }
    
    override func layoutSubviews() {
        roundCardView()
        roundImage()
    }
}
