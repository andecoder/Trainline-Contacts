//
//  ContactsTableViewControllerTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 31/10/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactsTableViewControllerTests: XCTestCase {

    func test_has_no_contacts_when_view_loads() {
        let sut = ContactsTableViewController()
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
    }

    func test_display_updated_contact_list() {
        let sut = ContactsTableViewController()
        let contacts: [ContactCellViewModel] = [
            ContactCellViewModel(name: "John Appleseed", contactMethod: "Post"),
            ContactCellViewModel(name: "Velma Combs", contactMethod: "e-Mail"),
            ContactCellViewModel(name: "Porter Coffey", contactMethod: "SMS")
        ]
        sut.display(contacts)
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 3)
    }

    func test_display_correct_contact_information() {
        let sut = ContactsTableViewController()
        let contacts: [ContactCellViewModel] = [
            ContactCellViewModel(name: "John Appleseed", contactMethod: "Post"),
            ContactCellViewModel(name: "Velma Combs", contactMethod: "e-Mail"),
            ContactCellViewModel(name: "Porter Coffey", contactMethod: "SMS")
        ]
        sut.display(contacts)

        let row1 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertEqual(row1.textLabel?.text, "John Appleseed")
        XCTAssertEqual(row1.detailTextLabel?.text, "Post")

        let row2 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 1))
        XCTAssertEqual(row2.textLabel?.text, "Velma Combs")
        XCTAssertEqual(row2.detailTextLabel?.text, "e-Mail")

        let row3 = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 2, section: 1))
        XCTAssertEqual(row3.textLabel?.text, "Porter Coffey")
        XCTAssertEqual(row3.detailTextLabel?.text, "SMS")
    }
}
