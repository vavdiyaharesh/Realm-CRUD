//
//  Realm_CRUDUITests.swift
//  Realm-CRUDUITests
//
//  Created by Vavdiya Haresh on 29/12/20.
//

import XCTest
import RealmSwift
@testable import Realm_CRUD

class Realm_CRUDUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.launch()
        let dignizantFamilyNavigationBar = app.navigationBars["Dignizant Family"]
        dignizantFamilyNavigationBar.buttons["Add"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.otherElements.containing(.button, identifier:"Save").children(matching: .other).element
        let enterHereTextField = element.children(matching: .other).element(boundBy: 0).textFields["Enter here"]
        enterHereTextField.tap()
        enterHereTextField.typeText("Haresh")
        element.children(matching: .other).element(boundBy: 1).textFields["Enter here"].tap()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["CEO"].tap()
        let enterHereTextField2 = element.children(matching: .other).element(boundBy: 2).textFields["Enter here"]
        enterHereTextField2.tap()
        enterHereTextField2.typeText("28") // If your app crush here then must be un-check the "Connection Hardware Keybaord" option is available e.g. Opne simulator or devices and go to the I/O menu and choose the keybaord option and uncheck the "Connection Hardware Keybaord" then run again.
        
        let saveButton = scrollViewsQuery.otherElements.buttons["Save"]
        saveButton.tap()
        
        let okButton = app.alerts["Alert"].scrollViews.otherElements.buttons["OK"]
        okButton.tap()
        
        app.navigationBars["Add New Employee"].buttons["Dignizant Family"].tap()
        dignizantFamilyNavigationBar.searchFields["Search by name"].tap()
        dignizantFamilyNavigationBar.buttons["Cancel"].tap()
        
        let table = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        table.swipeDown()
        app.tables.children(matching: .cell).element(boundBy: 0).tap()
        element.children(matching: .other).element(boundBy: 0).textFields["Enter here"].tap()
        let enterHereTextField0 = element.children(matching: .other).element(boundBy: 0).textFields["Enter here"]
        enterHereTextField0.tap()
        enterHereTextField0.typeText("Haresh Vavdiya")
        let enterHereTextField02 = element.children(matching: .other).element(boundBy: 2).textFields["Enter here"]
        enterHereTextField02.tap()
        enterHereTextField02.clearText()
        enterHereTextField02.typeText("34")
        saveButton.tap()
        app.alerts["Alert"].scrollViews.otherElements.buttons["OK"].tap()
        app.navigationBars["Edit Haresh"].buttons["Dignizant Family"].tap()
        table.swipeDown()
        tablesQuery.cells.containing(.staticText, identifier:"Haresh Vavdiya").element.swipeLeft()
        let deleteButton = tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteButton.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
extension XCUIElement {
    func clearText(andReplaceWith newText:String? = nil) {
        tap()
        tap() //When there is some text, its parts can be selected on the first tap, the second tap clears the selection
        press(forDuration: 1.0)
        let select = XCUIApplication().menuItems["Select"]
        //For empty fields there will be no "Select All", so we need to check
        if select.waitForExistence(timeout: 0.5), select.exists {
            select.tap()
            typeText(String(XCUIKeyboardKey.delete.rawValue))
        }
        if let newVal = newText { typeText(newVal) }
    }
}
