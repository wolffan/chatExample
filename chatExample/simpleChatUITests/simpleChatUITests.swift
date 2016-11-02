//
//  simpleChatUITests.swift
//  simpleChatUITests
//
//  Created by Raimon Lapuente on 23/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import XCTest

class simpleChatUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserCantBeNilOnLogin() {
        
        let app = XCUIApplication()
        app.buttons["LOGIN"].tap()
        XCTAssertNotNil(app.textFields["Please use different username"])

    }
    
    func testUsernameCantBeOneOfTheExistingOnBackend() {
        
        let app = XCUIApplication()
        let firstNameLastNameTextField = app.textFields["First Name & Last Name"]
        firstNameLastNameTextField.tap()
        firstNameLastNameTextField.typeText("Olivia")
        app.buttons["LOGIN"].tap()
        XCTAssertNotNil(app.textFields["Please use different username"])
    }
    
    func testUsernameValidMovesToNextScreen() {
        
        let app = XCUIApplication()
        let firstNameLastNameTextField = app.textFields["First Name & Last Name"]
        firstNameLastNameTextField.tap()
        firstNameLastNameTextField.typeText("Raimon")
        app.buttons["LOGIN"].tap()
        XCTAssertNotNil(XCUIApplication().navigationBars["Chat - Raimon"].staticTexts["Chat - Raimon"])
    }
    
    func testTypingAndSendingMessageDisplaysOnConversation() {
        
        let app = XCUIApplication()
        let firstNameLastNameTextField = app.textFields["First Name & Last Name"]
        firstNameLastNameTextField.tap()
        firstNameLastNameTextField.typeText("Rai")
        app.buttons["LOGIN"].tap()
        
        let typeSomethingTextField = app.textFields["Type something"]
        typeSomethingTextField.tap()
        typeSomethingTextField.typeText("hello all")
        app.buttons["SEND"].tap()
        XCTAssertNotNil(app.tables.staticTexts["hello all"])
    }
    
    func testLogoutReturnsToFirstScreen() {
        
        let app = XCUIApplication()
        app.navigationBars["Chat - Rai"].buttons["logout"].tap()
        XCTAssertNotNil(app.staticTexts["Type your name"])
        
    }
}
