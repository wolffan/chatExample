//
//  userRepository.swift
//  chatExample
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

protocol userStorage {
    func saveUser(username: String)
    func removeUser()
    func getSavedUser() -> String?
}

class userRepository : userStorage {
    
    let storage = UserDefaults.init()
    private static let userKey = "chat.Example.User"
    
    func saveUser(username: String) {
        storage.set(username, forKey: userRepository.userKey)
        storage.synchronize()
    }
    
    func removeUser() {
        storage.set(nil, forKey: userRepository.userKey)
        storage.synchronize()
    }
    
    func getSavedUser() -> String? {
        return storage.string(forKey: userRepository.userKey)
    }
}
