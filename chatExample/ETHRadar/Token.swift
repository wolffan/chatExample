//
//  Token.swift
//  ETHRadar
//
//  Created by Raimon Lapuente Ferran on 07/02/2018.
//  Copyright © 2018 Raimon Lapuente. All rights reserved.
//

import Foundation

class Token: NSObject, NSCoding {
    let name: String
    let amount: Double
    let ethValue: Double
    
    private static let encodernameKey = "nameStorage"
    private static let encoderamountKey = "amountStorage"
    private static let encoderethValueKey = "ethValueStorage"
    
    required init?(coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObject(forKey: Token.encodernameKey) as? String,
            let amount = aDecoder.decodeObject(forKey: Token.encoderamountKey) as? Double,
            let ethValue = aDecoder.decodeObject(forKey: Token.encoderethValueKey) as? Double {
            self.name = name
            self.amount = Double(amount)
            self.ethValue = ethValue
        } else {
            return nil
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: Token.encodernameKey)
        aCoder.encode(self.amount, forKey: Token.encoderamountKey)
        aCoder.encode(self.ethValue, forKey: Token.encoderethValueKey)
    }
    
    init(amount: Double, name: String, ethValue: Double) throws {
        self.name = name
        self.amount = Double(amount)
        self.ethValue = ethValue
    }
}
