//
//  MyAppUITests.swift
//  MyAppUITests
//
//  Created by Eloi Guzmán Cerón on 15/06/2017.
//  Copyright © 2017 Worldline. All rights reserved.
//

import XCTest
@testable import MyApp

class MyAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        SessionWorker.removeCurrentSession()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDoSuccesfulLogin() {
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let textField = elementsQuery.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField.typeText("username")
        app.children(matching: .window).element(boundBy: 1).buttons["ser ame"].tap()
        textField.tap()
        app.menuItems["Select"].tap()
        textField.typeText("userName")
        
        let textField2 = elementsQuery.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("password")
        elementsQuery.buttons["Login"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
