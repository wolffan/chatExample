//
//  ChatViewModelTests.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 02/11/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import XCTest
@testable import ETHRadar

class TokenViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChatViewModelShowsCorrectCoinName() {
        //given   
        let token = Token(amount: 2456.0, name: "GNT", rate: 0.345)
        let tokenViewModel = TokenCellViewModel.init(token: token)
        
        //then
        XCTAssertEqual(tokenViewModel.tokenAmount, "2456.0")
        XCTAssertEqual(tokenViewModel.tokenName, "Golem(GNT)")
        XCTAssertEqual(tokenViewModel.tokenEthValue, "847.32 ETH")
    }
    
    func testChatViewModelShowsUnknownCoinName() {
        //given
        let token = Token(amount: 2456.0, name: "REF", rate: 0.345)
        let tokenViewModel = TokenCellViewModel.init(token: token)
        
        //then
        XCTAssertEqual(tokenViewModel.tokenAmount, "2456.0")
        XCTAssertEqual(tokenViewModel.tokenName, "(REF)")
        XCTAssertEqual(tokenViewModel.tokenEthValue, "847.32 ETH")
    }
    
}
