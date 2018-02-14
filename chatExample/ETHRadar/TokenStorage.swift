//
//  DataStorage.swift
//  ETHRadar
//
//  Created by Raimon Lapuente Ferran on 12/02/2018.
//  Copyright © 2018 Raimon Lapuente. All rights reserved.
//

import Foundation

class TokenStorage: NSObject, NSCoding {
    
    private static let encoderKey = "tokenStorage"
    
    required init?(coder aDecoder: NSCoder) {
        if let decodedTokens = aDecoder.decodeObject(forKey: TokenStorage.encoderKey) as? [String:Token] {
            self.internalTokens = decodedTokens
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.internalTokens, forKey: TokenStorage.encoderKey)
    }
    
    private var internalTokens = [String:Token]()
    
    init(tokens:[String:Token]?) {
        if let safeTokens = tokens {
            self.internalTokens = safeTokens
        } else {
            self.internalTokens = [String:Token]()
        }
    }
    
    var tokens: [String:Token] {
        get {
            return internalTokens
        }
        set {
            internalTokens = tokens
        }
    }
    
    func update(token: String, value: Double) {
        if let oldToken = internalTokens[token] {
            let newToken = Token.init(amount: value, name: oldToken.name, rate: oldToken.rate)
            self.internalTokens[token] = newToken
        } else {
            let newToken = Token.init(amount: value, name: token, rate: 0)
            self.internalTokens[token] = newToken
        }
        saveData()
    }
    
    func updateRate(token: String, rate: Double) {
        if let oldToken = internalTokens[token] {
            let newToken = Token.init(amount: oldToken.amount, name: oldToken.name, rate: rate)
            self.internalTokens[token] = newToken
        } else {
            print("there should be a token")
        }
        saveData()
    }
    
}

extension TokenStorage {
    func saveData() {
        let result = NSKeyedArchiver.archiveRootObject(self.internalTokens, toFile: StorageHelper.getFilePath())
    }
    
    class func loadData() -> [String:Token]?  {
        if let loadedData = NSKeyedUnarchiver.unarchiveObject(withFile: StorageHelper.getFilePath()) as? [String:Token] {
            return loadedData
        }
        return nil
    }
}

class StorageHelper {
    static func getFilePath() -> String {
        let file = FileManager()
        let url = file.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path =  url.appendingPathComponent("tokens").path
        return path
    }
}
