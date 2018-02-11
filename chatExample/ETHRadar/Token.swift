//
//  Token.swift
//  ETHRadar
//
//  Created by Raimon Lapuente Ferran on 07/02/2018.
//  Copyright © 2018 Raimon Lapuente. All rights reserved.
//

import Foundation

struct Token {
    let name: String
    let amount: Double
    let ethBalue: Double
    
    init(amount: Double, name: String, rate: Double) throws {
        self.name = name
        self.amount = Double(amount)
        self.ethBalue = rate * self.amount
    }
}
