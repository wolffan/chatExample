//
//  ChatTableViewCell.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 26/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation
import UIKit

class Cell : UITableViewCell {
    func configWith(viewModel:TokenCellViewModel) {}
}

class TokenCell: Cell {
    
    @IBOutlet weak var tokenName: UILabel!
    @IBOutlet weak var tokenAmount: UILabel!
    @IBOutlet weak var tokenValue: UILabel!
    @IBOutlet weak var backgroundRound: UIView!
    
    override func prepareForReuse() {
        tokenName.text = ""
        tokenAmount.text = ""
        tokenValue.text = ""
    }
    
    override func awakeFromNib() {
        backgroundRound.layer.cornerRadius = 10.0
    }
    
    override func configWith(viewModel:TokenCellViewModel) {
        tokenValue.text = viewModel.tokenEthValue
        tokenName.text = viewModel.tokenName
        tokenAmount.text = viewModel.tokenAmount
    }
}
