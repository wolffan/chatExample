//
//  UserCheck.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 02/11/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

class UserCheck {
    
    let userList: userValidator
    
    init(userList: userValidator) {
        self.userList = userList
    }
    
    private func checkUserExists(username: String) -> Bool {
        let usernameList = self.userList.totalChattedUsers
        return usernameList().contains(username)
    }
    
    //Note: validate user should really return an enum with the exact error to be able to display to user, we are making it simpler
    func validUser(username: String) -> Bool {
        return username != "" && !self.checkUserExists(username: username)
    }
}
