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
    let dataRepo : DataRepository
    
    init?(window: UIWindow?) {
        guard let validWindow = window else {
            return nil
        }
        self.userRepo = userRepository()
        self.dataRepo = DataRepository()
        self.dataRepo.fetchAll()

        self.window = validWindow
        let (hasSession, username) = Router.hasStoredSession(userRepo: self.userRepo)
        self.navigation = UINavigationController.init(rootViewController: Router.createLogin(userRepo: self.userRepo))
    }
    
    func setUp() {
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
    }
    
    class func createLogin(userRepo : userStorage) -> ViewController {
        let login = ViewController.init()
        return login
    }
    
    class func createChatController(repository: ETHRepository) -> TokenController {
        let chatController = TokenController(repository: repository)
        return chatController
    }
    
    // -- Session methods --
    
    class func hasStoredSession(userRepo: userStorage) -> (Bool,String?) {
        if let user = userRepo.getSavedUser() {
            return (true, user)
        }
        return (false, nil)
    }
    
    // -- Navigation Methods --
    
    func openTokens(animated: Bool) {
        let chatController = Router.createChatController(repository: self.dataRepo)
        self.navigation.pushViewController(chatController, animated: animated)
    }
    
    func logout() {
        self.userRepo.removeUser()
        self.navigation.isNavigationBarHidden = true
        self.navigation.popViewController(animated: true)
    }
}
