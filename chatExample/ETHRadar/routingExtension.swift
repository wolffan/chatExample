//
//  routingExtension.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

protocol transferUser {
    func finisWithUsername(username: String)
}

extension ViewController: transferUser {
    
    func finisWithUsername(username: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        if let router = app.router {
            router.loginFinishedWithUser(username: username, animated: true)
        }
    }
}

protocol logoutUser {
    func userlogout()
}

extension TokenController: logoutUser {
    func userlogout() {
        let app = UIApplication.shared.delegate as! AppDelegate
        if let router = app.router {
            router.logout()
        }
    }
}
