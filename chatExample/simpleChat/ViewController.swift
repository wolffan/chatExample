//
//  ViewController.swift
//  chatExample
//
//  Created by Raimon Lapuente on 22/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import UIKit



class ViewController: UIViewController, keyboardAnimations, UITextFieldDelegate {
    
    @IBOutlet weak var bottomDistance: NSLayoutConstraint!
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
        
        self.registerForKeyboard()
    }

    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        self.usernameField.resignFirstResponder()
        if let username = usernameField.text {
            self.finisWithUsername(username: username)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameField.resignFirstResponder()
        return true
    }
    
    func animateKeyboardChange(height: Float) {
        self.bottomDistance.constant -= CGFloat(height)
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }

}

