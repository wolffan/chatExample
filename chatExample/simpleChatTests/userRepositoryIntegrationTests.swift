//
//  userRepositoryTests.swift
//  chatExample
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import XCTest
@testable import simpleChat

class userRepositoryIntegrationTests: XCTestCase {
    
    private static let userKey = "chat.Example.User"
    
    let userRepo = userRepository()

    override func setUp() {
        super.setUp()
        userRepo.removeUser()
    }
    
    override func tearDown() {
        userRepo.removeUser()
        super.tearDown()
    }
    
    func testUserSaveReturnsSavedUser() {
        //given
        let user = "Michael"
        
        //when
        userRepo.saveUser(username: user)
        
        //then
        XCTAssertEqual(userRepo.getSavedUser(), "Michael")
    }
    
    func testGetUserWhenNoUserReturnsNil() {
        //given
        let user = userRepo.getSavedUser()
        
        //then
        XCTAssertNil(user)
    }
    
    func testUserDeletion() {
        //given
        let user = "Tony"
        userRepo.saveUser(username: user)
        
        //when
        userRepo.removeUser()
        
        //then
        XCTAssertNil(userRepo.getSavedUser())
    }
    
}
