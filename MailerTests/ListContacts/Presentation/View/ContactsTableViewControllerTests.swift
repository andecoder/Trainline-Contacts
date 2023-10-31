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
        sut.hasNoContacts()
    }

    func test_display_correct_contact_information() {
        let sut = ContactsTableViewController()
        
        let contacts: [ContactCellViewModel] = ContactCellViewModel.dummyData
        sut.display(contacts)

        sut.isDisplaying(contacts)
    }
}

private extension ContactsTableViewController {

    func hasNoContacts(file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(tableView(tableView, numberOfRowsInSection: 0), 0, file: file, line: line)
    }

    func isDisplaying(_ contacts: [ContactCellViewModel], file: StaticString = #filePath, line: UInt = #line) {
        contacts.enumerated().forEach { (index, contact) in
            isDisplaying(contact, atIndex: index, file: file, line: line)
        }
    }

    private func isDisplaying(_ contact: ContactCellViewModel, atIndex index: Int, file: StaticString, line: UInt) {
        let row = tableView(tableView, cellForRowAt: IndexPath(row: index, section: 0))
        XCTAssertEqual(row.textLabel?.text, contact.name, file: file, line: line)
        XCTAssertEqual(row.detailTextLabel?.text, contact.contactMethod, file: file, line: line)
    }
}
