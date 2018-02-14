
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
        table.estimatedRowHeight = 45
        let nib : UINib = UINib(nibName: "TokenCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "TokenCell")
    }
    
    // -- Collection Delegates --
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let token = self.repository.getToken(position: indexPath.section)
        let viewModel = TokenCellViewModel.init(token:token)
        var cell : TokenCell
        cell = tableView.dequeueReusableCell(withIdentifier: "TokenCell", for: indexPath) as! TokenCell
        cell.configWith(viewModel: viewModel)
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.repository.allTokens()
    }
}
