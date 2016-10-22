//
//  ViewController.swift
//  chatExample
//
//  Created by Raimon Lapuente on 22/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var messageImage: UIImageView!
    let userRepo : userStorage
    
    init(userRepository: userStorage) {
        self.userRepo = userRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.layer.cornerRadius = 5.0
        self.usernameField.layer.cornerRadius = 5.0
    }

    @IBAction func loginButtonPressed(_ sender: AnyObject) {
    }

}

