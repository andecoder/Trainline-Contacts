//
//  ContactListScreen.swift
//  MailerUITests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

final class ContactListScreen {
  
    private let app = XCUIApplication()
    private lazy var phillipLabel = table.staticTexts["Phillip Murphy"].firstMatch
    private lazy var table = app.tables.firstMatch
    private lazy var view = app.navigationBars["Contacts"].firstMatch

    @discardableResult
    func open() -> Self {
        app.launch()
        return self
    }

    @discardableResult
    func selectPhillip() -> DetailsScreen {
        phillipLabel.tap()
        return DetailsScreen(app)
    }

    @discardableResult
    func scrollToPhillip(file: StaticString = #filePath, line: UInt = #line) -> Self {
        while !phillipLabel.isVisibleAndHittable() {
            let startCoordinate = table.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            let endCoordinate = startCoordinate.withOffset(CGVector(dx: 0.0, dy: -300))
            startCoordinate.press(forDuration: 0.01, thenDragTo: endCoordinate)
        }
        return self
    }

    @discardableResult
    func validateTablePopulated(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTAssertEqual(table.cells.count, 229, file: file, line: line)
        return self
    }

    @discardableResult
    func waitForExists(file: StaticString = #filePath, line: UInt = #line) -> Self {
        view.waitForExists(file: file, line: line)
        return self
    }
}
