//
//  BlueverseTests.swift
//  BlueverseTests
//
//  Created by Vaibhav Parmar on 26/05/20.
//  Copyright © 2020 Nickelfox. All rights reserved.
//

import XCTest
@testable import Model

class BlueverseTests: XCTestCase {
    
    func testSingleDigitVersionCheck() {
        // expecting currentApp version '1'
        
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "0.0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "1.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "1.0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "1.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "2.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "2.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1", "2.0.0.1"))
    }

    func testDoubleDigitVersionCheck() {
        // expecting currentApp version '1.0'
        
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "0.0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "1.0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "1.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "2.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "2.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0", "2.0.0.1"))
    }
    
    func testTripleDigitVersionCheck() {
        // expecting currentApp version '1.0.0'
        
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "0.0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "1.0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "1.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "2.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "2.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0", "2.0.0.1"))
    }
    
    func testQuadrupleDigitVersionCheck() {
        // expecting currentApp version '1.0.0.0'
        
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "0.0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "1.0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "1.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "2.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "2.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("1.0.0.0", "2.0.0.1"))
    }
    
    func testTripleDigitVersionAnotherCheck() {
        // expecting currentApp version '2.0.0'
        
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "0.0.0.9"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "1.0.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "1.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "2.0"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "2.0.0.1"))
        XCTAssertTrue(VersionCheck.isStoreVersionNewer("2.0.0", "2.0.0.1"))
    }
}
