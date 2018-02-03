//
//  DateHelpersTests.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 28/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import XCTest
@testable import simpleChat

class DateHelpersTests: XCTestCase {
    
    let dateFormatter : DateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        self.dateFormatter.dateFormat = "HH:mm"
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetTimeReturnsSimpleDigits() {
        //given
        let date = dateFormatter.date(from: "02:05")
        
        //when
        let time = DateHelper.getHourTime(date: date!)
        
        //then
        XCTAssertEqual(time,"02:05")
    }
    
    func testGetTimeReturnsDoubleDigits() {
        //given
        let date = dateFormatter.date(from: "12:32")
        
        //when
        let time = DateHelper.getHourTime(date: date!)
        
        //then
        XCTAssertEqual(time,"12:32")
    }
}
