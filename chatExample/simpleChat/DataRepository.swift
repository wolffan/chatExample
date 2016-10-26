//
//  DataRepository.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 25/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

class DataRepository {
    
    var chats: NSMutableArray = []
    
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
                                        self.chats.add(chat)
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
    
    func getAll() -> NSArray {
        return self.chats
    }
    
    func totalChats() -> NSInteger {
        return self.chats.count
    }
    
    func getChatAt(position: NSInteger) -> Chat {
        return self.chats[position] as! Chat
    }
}
