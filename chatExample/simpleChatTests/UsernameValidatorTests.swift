//
//  UsernameValidatorTests.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 02/11/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import XCTest
@testable import simpleChat

class UserValidatorStub: userValidator {
    func totalChattedUsers() -> [String] {
        return ["Morgan","Chris","Jhon","Julie","Marso","Joanna","Phil","Garfield"]
    }
}

class UsernameValidatorTests: XCTestCase {
    
    var userListStub : userValidator?
    var userValidator : UserCheck?
    
    override func setUp() {
        super.setUp()
        userListStub = UserValidatorStub()
        userValidator = UserCheck.init(userList: self.userListStub!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserIsValid() {
        // given
        let username = "Raimon"
        
        //then
        XCTAssertTrue((self.userValidator?.validUser(username: username))!)
    }

    func testExistingUserIsNotValid() {
        // given
        let username = "Morgan"
        
        //then
        XCTAssertFalse((self.userValidator?.validUser(username: username))!)
    }
    
    func testEmptyStringUserIsNotValid() {
        // given
        let username = ""
        
        //then
        XCTAssertFalse((self.userValidator?.validUser(username: username))!)
    }
}
