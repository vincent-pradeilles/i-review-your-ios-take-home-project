//
//  PokemonGuideUITests.swift
//  PokemonGuideUITests
//
//  Created by   on 13.03.2024.
//

import XCTest

extension XCUIElement {
    func tap(wait: Int, test: XCTestCase) {
        if !isHittable {
            test.expectation(for: NSPredicate(format: "hittable == true"), evaluatedWith: self, handler: nil)
            test.waitForExpectations(timeout: TimeInterval(wait), handler: nil)
        }
        tap()
    }
}

final class PokemonGuideUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSwiftUIListViewCellTap() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["SwiftUI"].tap(wait: 20, test: self)
        
        sleep(2)
        
//        let staticTexts = app.buttons.allElementsBoundByIndex
//        for (index, staticText) in staticTexts.enumerated() {
//            print("button \(index): \(staticText.label)")
//        }
        
        app.otherElements.element(boundBy: 1).tap(wait: 20, test: self)
        
        XCTAssertTrue(app.staticTexts["detailTitle"].exists)
    }
    
    func testUIKitListViewCellTap() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["UIKit"].tap(wait: 20, test: self)
        
        let detail = app.cells.element(boundBy: 0)
        XCTAssertTrue(detail.exists)
        detail.tap(wait: 20, test: self)
        
        XCTAssertTrue(app.staticTexts["detailLabel"].exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
