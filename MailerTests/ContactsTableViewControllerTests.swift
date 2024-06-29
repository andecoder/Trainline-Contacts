//
//  ContactsTableViewControllerTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 29/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactsTableViewControllerTests: XCTestCase {

    func test_fetch_contacts_on_load() {
        var didLoadContacts: Bool = false
        let sut = ContactsTableViewController { didLoadContacts = true }
        sut.loadViewIfNeeded()
        XCTAssertTrue(didLoadContacts)
    }

    func test_table_is_empty_when_view_loads() {
        let sut = ContactsTableViewController { }
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
}
