//
//  MeChatTableViewCell.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 31/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class MeChatTableViewCell: conversationCell {
    
    @IBOutlet weak var conversationText: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var backgroundRound: UIView!
    
    override func prepareForReuse() {
        time.text = ""
        conversationText.text = ""
    }
    
    override func awakeFromNib() {
        self.backgroundRound.layer.cornerRadius = 10.0
    }
    
    override func configWith(viewModel:ChatViewModel) {
        self.conversationText.text = viewModel.conversation
        self.time.text = viewModel.time
    }
}

