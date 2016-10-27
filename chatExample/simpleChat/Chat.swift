//
//  Chat.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 26/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

class Chat {
    let username: String
    let content: String
    let userImageURL: URL?
    let time: String
    
    init(username: String, content: String, userImage: String?, time: String) {
        self.username = username
        self.content = content
        if let image = userImage {
            self.userImageURL = URL.init(string: image)
        } else {
            self.userImageURL = nil
        }
        self.time = time
    }
    
    class func initWithJson(json: [String:Any]) -> Chat? {
        if let username = json["username"] as! String?, let content = json["content"] as! String?, let userImage = json["userImage_url"] as! String?, let time = json["time"] as! String? {
            let chat = Chat(username: username, content: content, userImage: userImage, time: time)
            return chat
        }
        return nil
    }
}
