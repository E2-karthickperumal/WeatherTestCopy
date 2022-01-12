//
//  weatherTestUITests.swift
//  weatherTestUITests
//
//  Created by e2info  on 07/01/22.
//

import XCTest

@testable import weatherTest

class weatherTestUITests: XCTestCase {

   //Mark - TableCell and SegementController Clickable
    func testSegmentControlAndTableCellClick(){
        
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.segmentedControls.buttons.element(boundBy: 0).isSelected)
        let segmentIndexCount = app.segmentedControls.buttons.count
        var segmentIndex = 0
        while (segmentIndex<segmentIndexCount) {
            app.segmentedControls.buttons.element(boundBy: segmentIndex).tap()
            cellTesting(totalCount: app.tables.cells.count)
            segmentIndex += 1
        }
    }
    
    func cellTesting(totalCount:Int){
        let app = XCUIApplication()
        var startIndex = 0
        while(startIndex<totalCount){
            app.tables.cells.element(boundBy: startIndex).tap()
            app.buttons["Back"].tap()
            startIndex += 1
        }
    }

}
