//
//  ViewController.swift
//  chatExample
//
//  Created by Raimon Lapuente on 22/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import UIKit



class ViewController: UIViewController, keyboardAnimations, UITextFieldDelegate {

    @IBOutlet weak var ETHLabel: UILabel!
    @IBOutlet weak var TokenLabel: UILabel!
    @IBOutlet weak var viewTokensButton: UIButton!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.registerForKeyboard()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.deregisterKeyboard()
    }
        
    @IBAction func viewMoreTapped(_ sender: Any) {
        self.showTokens()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    func animateKeyboardChange(height: Float) {
//        if self.bottomDistance.constant < 0 && height > 0 { return }

//        self.bottomDistance.constant -= CGFloat(height)
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

