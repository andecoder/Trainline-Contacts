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
        let sut = ContactsTableViewController { _ in didLoadContacts = true }
       
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(didLoadContacts)
    }

    func test_table_is_empty_when_view_loads() {
        let sut = ContactsTableViewController { _ in }
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_display_contacts_when_request_succeeds() {
        let sut = ContactsTableViewController { completion in
            let dummyContact = ContactViewModel(name: "DUMMY", contactMethod: "DUMMY")
            let names = [dummyContact, dummyContact, dummyContact]
            completion(names)
        }
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }

    func test_display_correct_cell_information() throws {
        let contact = ContactViewModel(name: "James Cameron", contactMethod: "SMS")
        let sut = ContactsTableViewController { completion in
            completion([contact])
        }
        
        sut.loadViewIfNeeded()

        let cell = try XCTUnwrap(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
        XCTAssertEqual(cell.textLabel?.text, contact.name)
        XCTAssertEqual(cell.detailTextLabel?.text, contact.contactMethod)
    }
}
