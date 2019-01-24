//
//  CustomNumberPadUITests.swift
//  CustomNumberPadUITests
//
//  Created by Mickey on 2018/6/26.
//  Copyright © 2018年 Mickey. All rights reserved.
//

import XCTest

class CustomNumberPadUITests: XCTestCase {
        
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
    
    func testButtons() {
        
        let app = XCUIApplication()
        let window = app.children(matching: .window).element(boundBy: 0)
        window.otherElements.children(matching: .textField).element.tap()
        
        let button = app.buttons["1"]
        button.tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["4"].tap()
        app.buttons["5"].tap()
        app.buttons["6"].tap()
        app.buttons["7"].tap()
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["0"].tap()
        
        let cButton = app.buttons["C"]
        cButton.tap()
        cButton.tap()
        cButton.tap()
        cButton.tap()
        cButton.tap()
        cButton.tap()
        cButton.tap()
        cButton.tap()
        cButton.tap()
        cButton.tap()
        cButton.tap()
        button.tap()
        app.children(matching: .window).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 9).tap()
        window.children(matching: .other).element.tap()
        
    }
    
}
