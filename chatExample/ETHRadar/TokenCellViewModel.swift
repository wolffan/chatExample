//
//  ChatViewModel.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 02/11/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

class TokenCellViewModel {
    
    let tokenAmount: String
    let tokenName: String
    let tokenEthValue: String
    
    private let token: Token
    
    init(token: Token) {
        self.token = token
        if let coin: Coins = Coins(rawValue:self.token.name) {
            self.tokenName = "\(coin.fullName())(\(self.token.name))"
        } else {
            self.tokenName = "(\(self.token.name))"
        }
        self.tokenAmount = "\(self.token.amount)"
        self.tokenEthValue = "\(self.token.amount * self.token.rate) ETH"
    }
}
