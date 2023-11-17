//
//  ContactMethodContactLoaderServiceDecoratorTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 17/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactMethodContactLoaderServiceDecoratorTests: XCTestCase {

    func test_returns_contacts_with_post_contact() {
        expect(.john, from: .post)
    }

    func test_returns_contacts_with_sms_contact() {
        expect(.porter, from: .sms)
    }

    func test_returns_contacts_with_email_contact() {
        expect(.velma, from: .email)
    }

    // MARK: Helpers

    private func expect(_ contact: Contact, from contactMethod: ContactMethod, file: StaticString = #filePath, line: UInt = #line) {
        let sut = ContactMethodContactLoaderServiceDecorator(
            contactMethod: contactMethod,
            repository: FakeRepository()
        )
        checkForMemoryLeak(on: sut, file: file, line: line)
        var receivedContacts: [Contact]?
        let expectation = XCTestExpectation()
        sut.loadContacts { result in
            receivedContacts = try! result.get()
            expectation.fulfill()
        }
        wait(for: [expectation])
        XCTAssertEqual(receivedContacts, [contact])
    }
}
