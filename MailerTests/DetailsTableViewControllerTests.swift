//
//  DetailsTableViewControllerTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class DetailsTableViewControllerTests: XCTestCase {

    func test_set_title_when_created() {
        let title = "My Custom Title"
        let sut = DetailsTableViewController(title: title) { }
        XCTAssertEqual(sut.title, title)
    }

    func test_fetch_contacts_on_load() {
        var didLoadContacts: Bool = false
        let sut = DetailsTableViewController(title: "DUMMY") { didLoadContacts = true }

        sut.loadViewIfNeeded()

        XCTAssertTrue(didLoadContacts)
    }
}
