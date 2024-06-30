//
//  MailerUITests.swift
//  MailerUITests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

final class MailerUITests: XCTestCase {

    func test_main_flow() throws {
        let detailsScreen = ContactListScreen()
            .open()
            .waitForExists()
            .validateTablePopulated()
            .scrollToPhillip()
            .selectPhillip()

        detailsScreen
            .waitForExists()
            .validateTablePopulated()
    }
}
