//
//  Router.swift
//  chatExample
//
//  Created by Raimon Lapuente on 22/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

enum InitError : Error {
    case windowCantBeNil
}

class Router {
    let navigation : UINavigationController
    let window : UIWindow
    let userRepo : userStorage
    
    init?(window: UIWindow?) {
        guard let validWindow = window else {
            return nil
        }
        self.userRepo = userRepository()
        self.window = validWindow
        self.navigation = UINavigationController.init(rootViewController: Router.createLogin(userRepo: self.userRepo))
    }
    
    func setUp() {
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
    }
    
    class func createLogin(userRepo : userStorage) -> UIViewController {
        let login = ViewController.init(userRepository: userRepo)
        return login
    }
    
}
