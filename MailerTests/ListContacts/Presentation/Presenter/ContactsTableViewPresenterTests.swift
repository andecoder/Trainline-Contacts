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

    func test_loadContacts_make_request_to_service() {
        let service = ContactLoaderServiceSpy()
        let sut = ContactsTableViewPresenter(service: service)
        sut.loadContacts()
        XCTAssertTrue(service.loadContactsCalled)
    }

    func test_loadContacts_only_makes_one_request_to_service() {
        let service = ContactLoaderServiceSpy()
        let sut = ContactsTableViewPresenter(service: service)
        sut.loadContacts()
        XCTAssertEqual(service.loadContactsCount, 1)
    }

    private final class ContactLoaderServiceSpy: ContactLoaderService {

        private(set) var loadContactsCalled = false
        private(set) var loadContactsCount = 0

        func loadContacts() {
            loadContactsCalled = true
            loadContactsCount += 1
        }
    }
}
