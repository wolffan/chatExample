//
//  IntegrationStorageTests.swift
//  ETHRadarTests
//
//  Created by Raimon Lapuente Ferran on 12/02/2018.
//  Copyright © 2018 Raimon Lapuente. All rights reserved.
//

import Foundation
import XCTest

@testable import ETHRadar

class IntegrationStorageTests: XCTestCase {
    
    override func tearDown() {
        TestHelper.cleanTokens()
        super.tearDown()
    }
    
    func testStorgeIsEmpty() {
        //given
        let storage = TokenStorage.loadData()
        
        //then
        XCTAssertNil(storage, "Storaget should be nil")
    }
    
    func testStorageWhenNotEmpty() {
        //given
        let token = Token.init(amount: 2.52, name: "aToken", ethValue: 0.25)
        let oneToken = TokenStorage.init(tokens: [token])
        oneToken.saveData()
        
        //when
        let readData = TokenStorage.loadData()
        
        //then
        XCTAssertEqual(readData?.count, 1)
    }
}

class TestHelper {
    class func cleanTokens () {
        let fileManager = FileManager.default
        try? fileManager.removeItem(atPath: StorageHelper.getFilePath())
    }
}
