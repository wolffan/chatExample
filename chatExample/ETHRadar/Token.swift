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
    let rate: Double
    
    private static let encodernameKey = "nameStorage"
    private static let encoderamountKey = "amountStorage"
    private static let encoderethValueKey = "rateStorage"
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: Token.encodernameKey) as? String  else {
            print("something happened")
            return nil
        }
        let amount = aDecoder.decodeDouble(forKey: Token.encoderamountKey)
        let ethValue = aDecoder.decodeDouble(forKey: Token.encoderethValueKey)
        self.name = name
        self.amount = Double(amount)
        self.rate = ethValue
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Token.encodernameKey)
        aCoder.encode(amount, forKey: Token.encoderamountKey)
        aCoder.encode(rate, forKey: Token.encoderethValueKey)
    }
    
    init(amount: Double, name: String, ethValue: Double) {
        self.name = name
        self.amount = Double(amount)
        self.rate = ethValue
    }
    
    
}
