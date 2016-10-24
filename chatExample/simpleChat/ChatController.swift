
//
//  chatController.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class ChatController: UIViewController {
    
    let username: String
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ("Chat - " + username)
        
        // remove back button
        self.hideBackButton()
        // add logout button
        self.addLogoutButton()
        // configure collection
        
        //fetch chat info - needs repository
        
        //animations for text and keyboard
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func addLogoutButton() {
        let logoutButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutPressed))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    func logoutPressed() {
        
    }
}
