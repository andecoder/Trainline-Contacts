//
//  XCUIElement+Helpers.swift
//  MailerUITests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

extension XCUIElement {

    func isVisibleAndHittable() -> Bool {
        guard exists, isHittable, !frame.isEmpty else {
            return false
        }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }

    func waitForExists(file: StaticString, line: UInt) {
        XCTAssertTrue(
            waitForExistence(timeout: 20),
            "Element \(self) failed to exist before timeout",
            file: file,
            line: line
        )
    }
}
