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
        if let decodedTokens = aDecoder.decodeObject(forKey: TokenStorage.encoderKey) as? [Token] {
            self.internalTokens = decodedTokens
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.internalTokens, forKey: TokenStorage.encoderKey)
    }
    
    private var internalTokens = [Token]()
    
    init(tokens:[Token]) {
        self.internalTokens = tokens
    }
    
    var tokens: [Token] {
        get {
            return internalTokens
        }
        set {
            internalTokens = tokens
        }
    }
    
}

extension TokenStorage {
    func saveData() {
        NSKeyedArchiver.archiveRootObject(self.internalTokens, toFile: StorageHelper.getFilePath())
    }
    
    func loadData()  {
        if let loadedData = NSKeyedUnarchiver.unarchiveObject(withFile: StorageHelper.getFilePath()) as? [Token] {
            self.internalTokens = loadedData
        }
    }
}

class StorageHelper {
    static func getFilePath() -> String {
        let file = FileManager.default
        let url = file.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent("Data").path
    }
}
