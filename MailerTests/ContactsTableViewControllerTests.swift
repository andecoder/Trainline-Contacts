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
            let dummyContact = ContactViewModel(name: "DUMMY", contactMethod: "DUMMY")
            let names = [dummyContact, dummyContact, dummyContact]
            completion(names)
        })
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }

    func test_display_correct_cell_information() throws {
        let contact = ContactViewModel(name: "James Cameron", contactMethod: "SMS")
        let sut = makeSUT(loadContacts: { completion in completion([contact]) })

        let cell = try XCTUnwrap(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)))
        XCTAssertEqual(cell.textLabel?.text, contact.name)
        XCTAssertEqual(cell.detailTextLabel?.text, contact.contactMethod)
    }

    func test_present_detail_screen_when_cell_selected() {
        var selectedViewModel: ContactViewModel?
        let contact = ContactViewModel(name: "Percy Jackson", contactMethod: "Mail")
        let sut = makeSUT(
            displayDetails: { viewModel in selectedViewModel = viewModel },
            loadContacts: { completion in completion([contact]) }
        )

        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(selectedViewModel, contact)
    }

    // MARK: Helpers

    private func makeSUT(
        displayDetails: @escaping ContactsTableViewController.DisplayDetails = { _ in },
        loadContacts: @escaping ContactsTableViewController.LoadContacts = { _ in }
    ) -> ContactsTableViewController {
        let viewController = ContactsTableViewController(displayDetails: displayDetails, loadContacts: loadContacts)
        viewController.loadViewIfNeeded()
        addTeardownBlock { [weak viewController] in
            XCTAssertNil(viewController)
        }
        return viewController
    }
}

extension ContactViewModel: Equatable {
    public static func == (lhs: ContactViewModel, rhs: ContactViewModel) -> Bool {
        lhs.name == rhs.name && lhs.contactMethod == rhs.contactMethod
    }
}
