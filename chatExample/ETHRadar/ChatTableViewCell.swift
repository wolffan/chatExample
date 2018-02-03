//
//  ChatTableViewCell.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 26/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class conversationCell : UITableViewCell {
    func configWith(viewModel:ChatViewModel) {}
}

class ChatTableViewCell: conversationCell {
    
    @IBOutlet weak var conversationText: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var backgroundRound: UIView!
    
    override func prepareForReuse() {
        time.text = ""
        conversationText.text = ""
        userImage.image = nil
        userImage.isHidden = true
    }
    
    override func awakeFromNib() {
        backgroundRound.layer.cornerRadius = 10.0
    }
    
    override func configWith(viewModel:ChatViewModel) {
        conversationText.text = viewModel.conversation
        time.text = viewModel.time
        if let image = viewModel.logo {
            userImage.downloadFrom(link: image)
        }
    }
}
