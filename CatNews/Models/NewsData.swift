//
//  NewsData.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/23/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation

struct ResponseData : Decodable{
    var code : Int
    var message : String
    var data : Array<NewsData>
}

struct NewsData : Decodable {
    var title : String
    var desc : String
    var image_url : String
    var timestamp : String
    var hour : String?
    var date : String?
}
