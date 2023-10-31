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
}
