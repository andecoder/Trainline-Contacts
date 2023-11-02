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

    private final class ContactLoaderServiceSpy: ContactLoaderService {

        private(set) var loadContactsCalled = false

        func loadContacts() {
            loadContactsCalled = true
        }
    }
}
