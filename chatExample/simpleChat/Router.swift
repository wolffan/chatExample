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
    let userCheck : UserCheck
    
    init?(window: UIWindow?) {
        guard let validWindow = window else {
            return nil
        }
        self.userRepo = userRepository()
        self.dataRepo = DataRepository()
        self.dataRepo.fetch()
        self.userCheck = UserCheck.init(userList: self.dataRepo)

        self.window = validWindow
        let (hasSession, username) = Router.hasStoredSession(userRepo: self.userRepo)
        self.navigation = UINavigationController.init(rootViewController: Router.createLogin(userRepo: self.userRepo, userCheck: self.userCheck))
        if hasSession {
            self.loginFinishedWithUser(username: username!, animated: false)
        }
    }
    
    func setUp() {
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
    }
    
    class func createLogin(userRepo : userStorage, userCheck: UserCheck) -> ViewController {
        let login = ViewController(userVaildator:userCheck)
        return login
    }
    
    class func createChatController(username: String, repository: chatRepository) -> ChatController {
        let chatController = ChatController(username: username, repository: repository)
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
    
    func loginFinishedWithUser(username: String, animated: Bool) {
        self.userRepo.saveUser(username: username)
        let chatController = Router.createChatController(username: username, repository: self.dataRepo)
        self.navigation.pushViewController(chatController, animated: animated)
    }
    
    func logout() {
        self.userRepo.removeUser()
        self.navigation.popViewController(animated: true)
    }
}
