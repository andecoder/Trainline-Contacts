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
        let sut = ContactsTableViewController(
            displayDetails: { _ in },
            loadContacts: { _ in didLoadContacts = true }
        )

        sut.loadViewIfNeeded()
        
        XCTAssertTrue(didLoadContacts)
    }

    func test_table_is_empty_when_view_loads() {
        let sut = ContactsTableViewController(
            displayDetails: { _ in },
            loadContacts: { _ in }
        )

        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_display_contacts_when_request_succeeds() {
        let sut = ContactsTableViewController(
            displayDetails: { _ in },
            loadContacts: { completion in
                let dummyContact = ContactViewModel(name: "DUMMY", contactMethod: "DUMMY")
                let names = [dummyContact, dummyContact, dummyContact]
                completion(names)
            }
        )

        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }

    func test_display_correct_cell_information() throws {
        let contact = ContactViewModel(name: "James Cameron", contactMethod: "SMS")
        let sut = ContactsTableViewController(
            displayDetails: { _ in },
            loadContacts: { completion in
                completion([contact])
            }
        )

        sut.loadViewIfNeeded()

        let cell = try XCTUnwrap(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
        XCTAssertEqual(cell.textLabel?.text, contact.name)
        XCTAssertEqual(cell.detailTextLabel?.text, contact.contactMethod)
    }

    func test_present_detail_screen_when_cell_selected() {
        var selectedViewModel: ContactViewModel?
        let contact = ContactViewModel(name: "Percy Jackson", contactMethod: "Mail")
        let sut = ContactsTableViewController(
            displayDetails: { viewModel in
                selectedViewModel = viewModel
            },
            loadContacts: { completion in
                completion([contact])
            }
        )

        sut.loadViewIfNeeded()
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(selectedViewModel, contact)
    }
}

extension ContactViewModel: Equatable {
    public static func == (lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
        lhs.name == rhs.name && lhs.contactMethod == rhs.contactMethod
    }
}
