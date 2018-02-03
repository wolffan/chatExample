
//
//  chatController.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource, keyboardAnimations, UITextFieldDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var chatBox: UITextField!
    @IBOutlet weak var chatContainer: UIView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var bottomSpaceToChatBox: NSLayoutConstraint!
    
    let username: String
    let repository: chatRepository
    
    init(username: String, repository: chatRepository) {
        self.username = username
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ("Chat - " + username)
        
        self.hideBackButton()
        self.addLogoutButton()
        self.configureTable()
        self.registerForKeyboard()
        self.configureTextBox()
        
        self.navigationController?.isNavigationBarHidden = false

    }
    
    func configureTextBox() {
        self.chatBox.layer.cornerRadius = 5.0
    }
    
    func configureTable() {
        self.table.rowHeight = UITableViewAutomaticDimension
        self.table.estimatedRowHeight = 120
        var nib : UINib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        self.table.register(nib, forCellReuseIdentifier: "ChatTableViewCell")
        nib = UINib(nibName: "MeChatTableViewCell", bundle: nil)
        self.table.register(nib, forCellReuseIdentifier: "MeChatTableViewCell")
        
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func addLogoutButton() {
        let logoutImage = UIImage(named: "logout")
        let logoutButton = UIBarButtonItem(image: logoutImage, style: .plain, target: self, action: #selector(logoutPressed))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logoutPressed() {
        self.deregisterKeyboard()
        self.userlogout()
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        self.chatBox.resignFirstResponder()
        if let text = self.chatBox.text, text != "" {
            self.addChat(text:text)
            self.table.reloadData()
            
            //do on becomefirstresponder
            let lastElement = self.repository.totalChats() - 1
            let indexPath = IndexPath(item: 0, section: lastElement)
            self.table.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
        }
        self.chatBox.text = ""
    }
    
    func animateKeyboardChange(height: Float) {
        self.bottomSpaceToChatBox.constant += CGFloat(height)
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text == "" {
            return false
        }
        return true
    }
    
    func addChat(text: String) {
        self.repository.addChat(user: self.username, text: text)
    }
    
    // -- Collection Delegates --
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = self.repository.getChatAt(position: indexPath.section)
        let viewModel = ChatViewModel.init(chat: chat,username:self.username)
        var cell : conversationCell
        if viewModel.me {
            cell = tableView.dequeueReusableCell(withIdentifier: "MeChatTableViewCell", for: indexPath) as! MeChatTableViewCell
            cell.configWith(viewModel:viewModel)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
            cell.configWith(viewModel: viewModel)
        }
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.repository.totalChats()
    }
}
