//
//  FourChanAPITests.swift
//  FourChanAPITests
//
//  Created by Erik Little on 5/11/16.
//  Copyright © 2016 Erik Little. All rights reserved.
//

import XCTest
@testable import FourChanAPI

class FourChanAPITests: XCTestCase {
    var board: FCBoard!
    
    override func setUp() {
        super.setUp()
        board = FCBoard(name: "a")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
