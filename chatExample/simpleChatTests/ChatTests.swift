//
//  ChatTests.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 02/11/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import XCTest
@testable import simpleChat

class ChatTests: XCTestCase {
    
    func testChatInitializer() {
        // given
        let chat = Chat(username: "user1", content: "random content", userImage: "RandomString", time: "12:43")
        
        //then
        XCTAssertEqual("user1", chat.username)
        XCTAssertEqual("random content", chat.content)
        let url = URL.init(string: "RandomString")
        XCTAssertEqual(url, chat.userImageURL)
        XCTAssertEqual("12:43", chat.time)
    }
    
    func testChatWithoutUserImage() {
        // given
        let chat = Chat(username: "user1", content: "random content", userImage:nil, time: "12:43")
        
        //then
        XCTAssertEqual("user1", chat.username)
        XCTAssertEqual("random content", chat.content)
        XCTAssertNil(chat.userImageURL)
        XCTAssertEqual("12:43", chat.time)
    }
    
    func testFilterHttpRequestLogic() {
        // given
        let chat = Chat(username: "user1", content: "random content", userImage:"http://myurl.com", time: "12:43")
        
        //then
        let url = URL.init(string: "https://myurl.com")
        XCTAssertEqual(url, chat.userImageURL)
    }
}
