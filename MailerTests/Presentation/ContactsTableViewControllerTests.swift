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
        _ = makeSUT(loadContacts: { _ in didLoadContacts = true })

        XCTAssertTrue(didLoadContacts)
    }

    func test_table_is_empty_when_view_loads() {
        let sut = makeSUT()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_display_contacts_when_request_succeeds() {
        let sut = makeSUT(loadContacts: { completion in
            let dummyContact = ContactViewModel(name: "DUMMY", contactMethod: .post)
            let names = [dummyContact, dummyContact, dummyContact]
            completion(names)
        })
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }

    func test_display_correct_cell_information() throws {
        let contact = ContactViewModel(name: "James Cameron", contactMethod: .sms)
        let sut = makeSUT(loadContacts: { completion in completion([contact]) })

        let cell = try XCTUnwrap(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
        XCTAssertEqual(cell.textLabel?.text, contact.name)
        XCTAssertEqual(cell.detailTextLabel?.text, contact.contactMethod.title)
    }

    func test_present_detail_screen_when_cell_selected() {
        var selectedContactMethod: ContactMethod?
        let contact = ContactViewModel(name: "Percy Jackson", contactMethod: .email)
        let sut = makeSUT(
            displayDetails: { contactMethod in selectedContactMethod = contactMethod },
            loadContacts: { completion in completion([contact]) }
        )

        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(selectedContactMethod, contact.contactMethod)
    }

    // MARK: Helpers

    private func makeSUT(
        displayDetails: @escaping ContactsTableViewController.DisplayDetails = { _ in },
        loadContacts: @escaping ContactsTableViewController.LoadContacts = { _ in }
    ) -> ContactsTableViewController {
        let viewController = ContactsTableViewController(displayDetails: displayDetails, loadContacts: loadContacts)
        viewController.loadViewIfNeeded()
        trackMemoryLeaks(on: viewController)
        return viewController
    }
}

extension ContactViewModel: Equatable {
    public static func == (lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
        lhs.name == rhs.name && lhs.contactMethod == rhs.contactMethod
    }
}
