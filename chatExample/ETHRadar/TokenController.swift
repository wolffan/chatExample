
//
//  chatController.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class TokenController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var table: UITableView!
        
    let repository: ETHRepository
    
    init(repository: ETHRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Token.Title", comment: "")
        
        configureTable()
        registerForKeyboard()
        
        navigationController?.isNavigationBarHidden = false

    }
    
    func configureTable() {
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 120
        var nib : UINib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "ChatTableViewCell")
        nib = UINib(nibName: "MeChatTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "MeChatTableViewCell")
        
    }
    
    // -- Collection Delegates --
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let chat = self.repository.getToken(position: indexPath.section)
//        let viewModel = ChatViewModel.init(chat: chat,username:"")
//        var cell : conversationCell
//        if viewModel.me {
//            cell = tableView.dequeueReusableCell(withIdentifier: "MeChatTableViewCell", for: indexPath) as! MeChatTableViewCell
//            cell.configWith(viewModel:viewModel)
//        } else {
//            cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
//            cell.configWith(viewModel: viewModel)
//        }
        return tableView.dequeueReusableCell(withIdentifier: "MeChatTableViewCell")!
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.repository.allTokens()
    }
}
