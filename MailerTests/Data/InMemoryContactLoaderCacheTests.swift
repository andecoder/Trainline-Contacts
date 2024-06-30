//
//  InMemoryContactLoaderCacheTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class InMemoryContactLoaderCacheTests: XCTestCase {

    func test_load_contacts_on_first_access() {
        var loaderCalled = false
        let sut = InMemoryContactLoaderCache { _ in loaderCalled = true }
        sut.load { _ in }
        XCTAssertTrue(loaderCalled)
    }

    func test_only_has_one_active_request() {
        var loadCount = 0
        let sut = InMemoryContactLoaderCache { _ in loadCount += 1 }

        sut.load { _ in }
        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(loadCount, 1)
    }

    func test_returns_received_contacts_on_completion() {
        let testContacts = [
            ContactViewModel(name: "Jane Doe", contactMethod: .email),
            ContactViewModel(name: "Clark Kent", contactMethod: .post)
        ]
        var receivedContacs: [ContactViewModel] = []
        let sut = InMemoryContactLoaderCache { completion in completion(testContacts) }
        sut.load { receivedContacs = $0 }
        XCTAssertEqual(receivedContacs, testContacts)
    }

    func test_returns_cached_contacts() {
        let testContacts = [
            ContactViewModel(name: "Peter Parker", contactMethod: .sms)
        ]
        var receivedContacs: [ContactViewModel] = []
        let sut = InMemoryContactLoaderCache { completion in
            completion(testContacts)
        }
        sut.load { _ in }
        sut.load { receivedContacs = $0 }
        XCTAssertEqual(receivedContacs, testContacts)
    }

    func test_return_contacts_with_same_contact_method() {
        let testContacts = [
            ContactViewModel(name: "Bruce Baner", contactMethod: .sms),
            ContactViewModel(name: "Tony Stark", contactMethod: .post)
        ]
        var receivedContacs: [String] = []
        let sut = InMemoryContactLoaderCache { completion in
            completion(testContacts)
        }
        sut.contacts(with: .post) { receivedContacs = $0 }
        XCTAssertEqual(receivedContacs, ["Tony Stark"])
    }
}
