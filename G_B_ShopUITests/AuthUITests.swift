//
//  AuthUITests.swift
//  G_B_ShopUITests
//
//  Created by emil kurbanov on 14.02.2022.
//

import XCTest

class AuthUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
     //   XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
    
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        let inputLoginTextField = elementsQuery.textFields["Введите Логин"]
        let inputPasswordTextField = elementsQuery.textFields["Введите Пароль"]
        let loginButton = elementsQuery.buttons["Login"].staticTexts["Login"]
        let logoutButton = elementsQuery/*@START_MENU_TOKEN@*/.buttons["Logout"].staticTexts["Logout"]/*[[".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
      
        inputLoginTextField.tap()
        inputLoginTextField.typeText("Donald")
        
        loginButton.swipeUp()
                
        inputPasswordTextField.tap()
        inputPasswordTextField.typeText("1234")
        
        loginButton.tap()
        
        logoutButton.tap()
    }
}
