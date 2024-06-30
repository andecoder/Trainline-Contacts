//
//  InMemoryContactLoaderCacheTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class InMemoryContactLoaderCache {

    private let loadContacts: (([ContactViewModel]) -> Void) -> Void
    private var loadCalled = false

    init(loadContacts: @escaping (([ContactViewModel]) -> Void) -> Void) {
        self.loadContacts = loadContacts
    }

    func load(completion: @escaping ([ContactViewModel]) -> Void) {
        guard !loadCalled else { return }
        loadContacts { contacts in completion(contacts) }
        loadCalled = true
    }
}

final class InMemoryContactLoaderCacheTests: XCTestCase {

    func test_load_contacts_on_first_access() {
        var loaderCalled = false
        let sut = InMemoryContactLoaderCache { _ in loaderCalled = true }
        sut.load { _ in }
        XCTAssertTrue(loaderCalled)
    }

    func test_does_not_load_contacts_on_subsequent_access() {
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
        sut.load { contacts in receivedContacs = contacts }
        XCTAssertEqual(receivedContacs, testContacts)
    }
}
