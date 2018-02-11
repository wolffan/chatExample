//
//  ChatViewModel.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 02/11/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

class ChatViewModel {
    
    let username : String
    let time : String
    let conversation : String
    let logo : URL?
    let me : Bool
    
    init(chat: Chat, username: String) {
        self.me = (chat.username == username)
        self.username = chat.username
        if !me {
            self.time = "\(chat.username) - \(chat.time)"
        } else {
            self.time = "\(chat.time)"

        }
        self.conversation = chat.content
        self.logo = chat.userImageURL
    }
}

struct TokenViewModel {
    let displayBalance: String
    let displayName: String
    let amount: Double
    
    
}
