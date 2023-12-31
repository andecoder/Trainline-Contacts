//
//  ContactsTableViewPresenterTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 31/10/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactsTableViewPresenterTests: XCTestCase {

    func test_loadContacts_only_makes_one_request_to_service() {
        let service = ContactLoaderServiceMock()
        _ = makeSUT(service: service)
        XCTAssertEqual(service.loadContactsCount, 1)
    }

    func test_display_empty_list_when_loadContacts_request_fails() {
        struct TestError: Error { }

        let service = ContactLoaderServiceMock()
        service.loadContactsReturn = .failure(TestError())
        let view = ContactListViewSpy()
        _ = makeSUT(service: service, view: view)
        XCTAssertEqual(view.displayedContacts, [])
    }

    func test_display_correct_contact_list_when_loadContacts_request_succeeds() {
        let view = ContactListViewSpy()
        _ = makeSUT(view: view)
        XCTAssertEqual(view.displayedContacts, ContactCellViewModel.dummyData)
    }

    // MARK: Helpers

    private func makeSUT(
        service: ContactLoaderServiceMock = ContactLoaderServiceMock(),
        view: ContactListViewSpy = ContactListViewSpy(),
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> ContactsTableViewPresenter {
        let sut = ContactsTableViewPresenter(service: service, view: view)
        sut.loadContacts()
        checkForMemoryLeak(on: service, file: file, line: line)
        checkForMemoryLeak(on: view, file: file, line: line)
        return sut
    }

    private final class ContactListViewSpy: ContactListView {

        private(set) var displayedContacts: [ContactCellViewModel]?

        func display(_ contacts: [ContactCellViewModel]) {
            displayedContacts = contacts
        }
    }
}
