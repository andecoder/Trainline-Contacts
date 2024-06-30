//
//  DetailsScreen.swift
//  MailerUITests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

final class DetailsScreen {

    private let app: XCUIApplication
    private lazy var table = app.tables.firstMatch
    private lazy var view = app.navigationBars["eMail"].firstMatch

    init(_ app: XCUIApplication) {
        self.app = app
    }

    @discardableResult
    func validateTablePopulated(file: StaticString = #filePath, line: UInt = #line) -> Self {
        XCTAssertEqual(table.cells.count, 5, file: file, line: line)
        return self
    }

    @discardableResult
    func waitForExists(file: StaticString = #filePath, line: UInt = #line) -> Self {
        view.waitForExists(file: file, line: line)
        return self
    }
}
