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
    
    init(chat: Chat) {
        self.username = chat.username
        self.time = "\(chat.username) - \(chat.time)"
        self.conversation = chat.content
        self.logo = chat.userImageURL
    }
}
