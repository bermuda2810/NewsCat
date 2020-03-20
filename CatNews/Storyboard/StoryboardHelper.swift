//
//  StoryboardHelper.swift
//  CatNews
//
//  Created by Bui Quoc Viet on 3/21/20.
//  Copyright © 2020 ClassiOS. All rights reserved.
//

import Foundation
import UIKit

class StoryBoardHelper: NSObject {
    
    public func getInitialViewController() -> UIViewController {
        let storyboardName = self.storyBoardName()
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
    }
    
    public func getViewControllerByIdentifier(identifier : String) -> UIViewController {
        let storyboardName = self.storyBoardName()
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func storyBoardName() -> String {
        return ""
    }
}


class MainStoryboard: StoryBoardHelper {
    override func storyBoardName() -> String {
        return "Main"
    }
}
