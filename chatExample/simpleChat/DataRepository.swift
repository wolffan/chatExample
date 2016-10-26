//
//  DataRepository.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 25/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

protocol chatRepository {
    func getAllChats() -> Array<Chat>
    func totalChats() -> NSInteger
    func getChatAt(position: NSInteger) -> Chat
}

protocol userValidator {
    func totalChattedUsers() -> [String]
}

class DataRepository: chatRepository, userValidator {
    
    var chats: Array = [Chat]()
    
    func fetch(){
        let url = URL(string:"https://s3-eu-west-1.amazonaws.com/rocket-interview/chat.json")
        let request = NSMutableURLRequest(url:url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        print("Something went wrong...")
                    } else {
                        
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) as? [String:[Any]]
                        if let Dictionary = json?["chats"] {
                            for chatDictionary in Dictionary {
                                if let chatObject = chatDictionary as? [String:Any] {
                                    if let chat = Chat.initWithJson(json: chatObject) {
                                        self.chats.append(chat)
                                    }
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Something went wrong...")
            }
        }
        
        task.resume()
    }
    
    func getAllChats() -> Array<Chat> {
        return self.chats
    }
    
    func totalChats() -> NSInteger {
        return self.chats.count
    }
    
    func getChatAt(position: NSInteger) -> Chat {
        return self.chats[position]
    }
    
    func totalChattedUsers() -> [String] {
        var contacts : [String] = [String]()
        for contact in self.chats {
            contacts.append(contact.username)
        }
        return contacts
    }
}
