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
        let result = NSKeyedArchiver.archiveRootObject(self.internalTokens, toFile: StorageHelper.getFilePath())
        print(result)
    }
    
    class func loadData() -> [Token]?  {
        if let loadedData = NSKeyedUnarchiver.unarchiveObject(withFile: StorageHelper.getFilePath()) as? [Token] {
            return loadedData
        }
        return nil
    }
}

class StorageHelper {
    static func getFilePath() -> String {
        let file = FileManager()
        let url = file.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(url)
        let path =  url.appendingPathComponent("tokens").path
        print(path)
        return path
    }
}
