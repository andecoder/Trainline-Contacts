//
//  ContactLoaderServiceAdapterTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 03/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactLoaderServiceAdapterTests: XCTestCase {

    func test_loadContacts_returns_correct_contacts() throws {
        let sut = ContactLoaderServiceAdapter(repository: FakeRepository())
        var receivedResult: Result<[Contact], Error>?
        sut.loadContacts() { receivedResult = $0 }
        XCTAssertEqual(try receivedResult?.get(), Contact.dummyData)
    }

    // MARK: Helpers

    private final class FakeRepository: ContactRepository {
        let contacts: [Contact] = Contact.dummyData
    }
}
