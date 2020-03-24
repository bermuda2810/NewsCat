//
//  ExtensionNSDictionary.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/20/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation

extension NSDictionary {
    public func safeValueFor(key : String, defaultValue : Any) -> Any {
        if let value = self.value(forKey: key){
            return value
        }
        return defaultValue
    }
}
