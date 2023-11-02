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
        let sut = ContactsTableViewPresenter(service: service, view: ContactListViewSpy())
        sut.loadContacts()
        XCTAssertEqual(service.loadContactsCount, 1)
    }

    func test_display_empty_list_when_loadContacts_request_fails() {
        let service = ContactLoaderServiceMock()
        let view = ContactListViewSpy()
        let sut = ContactsTableViewPresenter(service: service, view: view)
        sut.loadContacts()
        XCTAssertEqual(view.displayedContacts, [])
    }

    private final class ContactListViewSpy: ContactListView {

        private(set) var displayedContacts: [ContactCellViewModel]?

        func display(_ contacts: [ContactCellViewModel]) {
            displayedContacts = contacts
        }
    }

    private final class ContactLoaderServiceMock: ContactLoaderService {

        private(set) var loadContactsCount = 0

        func loadContacts() {
            loadContactsCount += 1
        }
    }
}

extension ContactCellViewModel: Equatable {
   
    public static func == (lhs: ContactCellViewModel, rhs: ContactCellViewModel) -> Bool {
        lhs.name == rhs.name && lhs.contactMethod == rhs.contactMethod
    }
}
