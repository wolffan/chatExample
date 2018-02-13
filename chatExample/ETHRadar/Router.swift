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
    let dataRepo : ETHRepository
    
    init?(window: UIWindow?) {
        guard let validWindow = window else {
            return nil
        }
        let storage = TokenStorage.init(tokens:TokenStorage.loadData())
        self.dataRepo = DataRepository.init(storage: storage)
        self.dataRepo.fetchAll()

        self.window = validWindow
        self.navigation = UINavigationController.init(rootViewController: Router.createMain(dataRepo: self.dataRepo))
    }
    
    func setUp() {
        self.window.rootViewController = navigation
        self.window.makeKeyAndVisible()
    }
    
    class func createMain(dataRepo : ETHRepository) -> ViewController {
        let viewModel = MainViewModel.init(repository: dataRepo)
        let login = ViewController.init(viewModel: viewModel)
        return login
    }
    
    class func createTokenController(repository: ETHRepository) -> TokenController {
        let chatController = TokenController(repository: repository)
        return chatController
    }
    
    // -- Navigation Methods --
    
    func openTokens(animated: Bool) {
        let chatController = Router.createTokenController(repository: self.dataRepo)
        self.navigation.pushViewController(chatController, animated: animated)
    }
    
    func logout() {
        self.navigation.isNavigationBarHidden = true
        self.navigation.popViewController(animated: true)
    }
}
