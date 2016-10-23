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
        // restore session
        let (hasSession, username) = Router.hasStoredSession(userRepo: self.userRepo)
        self.navigation = UINavigationController.init(rootViewController: Router.createLogin(userRepo: self.userRepo))
        if hasSession {
            self.loginFinishedWithUser(username: username!)
        }
    }
    
    func setUp() {
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
    }
    
    class func createLogin(userRepo : userStorage) -> ViewController {
        let login = ViewController()
        return login
    }
    
    class func createChatController(username: String) -> ChatController {
        let chatController = ChatController(username: username)
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
    
    func loginFinishedWithUser(username: String) {
        self.userRepo.saveUser(username: username)
        let chatController = Router.createChatController(username: username)
        self.navigation.pushViewController(chatController, animated: true)
    }
}
