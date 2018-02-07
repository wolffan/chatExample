//
//  ChatViewModelTests.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 02/11/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import XCTest
@testable import ETHRadar

class ChatViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChatViewModelShowsTimeAsUserAndTimeWhenNotmainUser() {
        //given   
        let chat = Chat(username: "user1", content: "random content", userImage: "RandomString", time: "12:43")
        let chatViewModel = ChatViewModel.init(chat: chat, username: "Olivia")
        
        //then
        XCTAssertEqual(chatViewModel.time, "user1 - 12:43")
        XCTAssertFalse(chatViewModel.me)
    }
    
    func testChatViewModelShowsTimeOnlyWhenUserIsMe() {
        //given
        let chat = Chat(username: "user1", content: "random content", userImage: "RandomString", time: "12:43")
        let chatViewModel = ChatViewModel.init(chat: chat, username: "user1")
        
        //then
        XCTAssertEqual(chatViewModel.time, "12:43")
        XCTAssertTrue(chatViewModel.me)
    }
    
}
