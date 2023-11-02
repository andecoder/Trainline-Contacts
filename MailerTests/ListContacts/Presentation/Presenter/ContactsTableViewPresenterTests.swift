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
        let sut = ContactsTableViewPresenter(service: service, view: ContactListViewSpy()) { _ in [] }
        sut.loadContacts()
        XCTAssertEqual(service.loadContactsCount, 1)
    }

    func test_display_empty_list_when_loadContacts_request_fails() {
        struct TestError: Error { }

        let service = ContactLoaderServiceMock()
        service.loadContactsReturn = .failure(TestError())
        let view = ContactListViewSpy()
        let sut = ContactsTableViewPresenter(service: service, view: view) { _ in [] }
        sut.loadContacts()
        XCTAssertEqual(view.displayedContacts, [])
    }

    func test_mapper_receives_contacts_from_successful_loadContacts_request() {
        let service = ContactLoaderServiceMock()
        let view = ContactListViewSpy()
        var receivedContacts: [Contact]?
        let expectation = XCTestExpectation()
        let sut = ContactsTableViewPresenter(service: service, view: view) { contacts in
            receivedContacts = contacts
            expectation.fulfill()
            return []
        }
        sut.loadContacts()
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(receivedContacts, Contact.dummyData)
    }

    private final class ContactListViewSpy: ContactListView {

        private(set) var displayedContacts: [ContactCellViewModel]?

        func display(_ contacts: [ContactCellViewModel]) {
            displayedContacts = contacts
        }
    }

    private final class ContactLoaderServiceMock: ContactLoaderService {

        var loadContactsReturn: Result<[Contact], Error> = .success(Contact.dummyData)

        private(set) var loadContactsCount = 0

        func loadContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
            loadContactsCount += 1
            completion(loadContactsReturn)
        }
    }
}
