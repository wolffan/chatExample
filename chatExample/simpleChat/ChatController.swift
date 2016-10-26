
//
//  chatController.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var chatBox: UITextField!
    @IBOutlet weak var chatContainer: UIView!
    @IBOutlet weak var sendButton: UIButton!
    
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

        self.table.rowHeight = UITableViewAutomaticDimension
        self.table.estimatedRowHeight = 120
        let nib : UINib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        self.table.register(nib, forCellReuseIdentifier: "ChatTableViewCell")
        
        //animations for text and keyboard
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func addLogoutButton() {
        let logoutImage = UIImage(named: "logout")
        let logoutButton = UIBarButtonItem(image: logoutImage, style: .plain, target: self, action: #selector(logoutPressed))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    func logoutPressed() {
        self.userlogout()
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
    }
    
    // -- Collection Delegates --
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        let chat = self.repository.getChatAt(position: indexPath.section)
        cell.conversationText.text = chat.content
        cell.time.text = "\(username) - \(chat.time)"
        cell.userImage .downloadFrom(link: chat.userImageURL!)
        cell.userImage.layer.cornerRadius = 20.0
        cell.userImage.layer.borderWidth = 2.0
        cell.userImage.layer.borderColor = UIColor.white.cgColor
        cell.userImage.clipsToBounds = true

        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.repository.totalChats()
    }
}
