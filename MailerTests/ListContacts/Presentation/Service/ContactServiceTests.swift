//
//  ContactServiceTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 03/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactServiceTests: XCTestCase {

    func test_loadContacts_returns_correct_contacts() {
        let sut = ContactService(repository: FakeRepository())
        var expectedContacts: [Contact]?
        sut.loadContacts() { expectedContacts = $0 }
        XCTAssertEqual(expectedContacts, Contact.dummyData)
    }

    // MARK: Helpers

    private final class FakeRepository: ContactRepository {
        let contacts: [Contact] = Contact.dummyData
    }
}
