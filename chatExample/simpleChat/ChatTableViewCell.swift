//
//  ChatTableViewCell.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 26/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class ChatTableViewCell: UITableViewCell {
    
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
        self.backgroundRound.layer.cornerRadius = 10.0
    }
}
