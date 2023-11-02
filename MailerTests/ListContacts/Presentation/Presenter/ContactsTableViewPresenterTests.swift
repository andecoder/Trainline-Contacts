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
        let sut = makeSUT(service: service)
        XCTAssertEqual(service.loadContactsCount, 1)
    }

    func test_display_empty_list_when_loadContacts_request_fails() {
        struct TestError: Error { }

        let service = ContactLoaderServiceMock()
        service.loadContactsReturn = .failure(TestError())
        let view = ContactListViewSpy()
        let sut = makeSUT(service: service, view: view)
        XCTAssertEqual(view.displayedContacts, [])
    }

    func test_mapper_receives_contacts_from_successful_loadContacts_request() {
        var receivedContacts: [Contact]?
        let expectation = XCTestExpectation()
        let sut = makeSUT { contacts in
            receivedContacts = contacts
            expectation.fulfill()
            return []
        }
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(receivedContacts, Contact.dummyData)
    }

    func test_display_correct_contact_list_when_loadContacts_request_succeeds() {
        let view = ContactListViewSpy()
        let sut = makeSUT(view: view) { _ in ContactCellViewModel.dummyData }
        XCTAssertEqual(view.displayedContacts, ContactCellViewModel.dummyData)
    }

    // MARK: Helpers

    private func makeSUT(
        service: ContactLoaderService = ContactLoaderServiceMock(),
        view: ContactListView = ContactListViewSpy(),
        mapper: @escaping ([Contact]) -> [ContactCellViewModel] = { _ in [] }
    ) -> ContactsTableViewPresenter {
        let sut = ContactsTableViewPresenter(service: service, view: view, mapper: mapper)
        sut.loadContacts()
        return sut
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
