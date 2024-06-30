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
    private var contacts: [ContactViewModel] = []

    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    init(loadContacts: @escaping (([ContactViewModel]) -> Void) -> Void) {
        self.loadContacts = loadContacts
    }

    func load(completion: @escaping ([ContactViewModel]) -> Void) {
        let operation = BlockOperation { [weak self] in
            guard let self else { return }
            guard contacts.isEmpty else {
                completion(contacts)
                return
            }
            loadContacts { [weak self] contacts in
                self?.contacts = contacts
                completion(contacts)
            }
        }
        queue.addOperation(operation)
    }
}

final class InMemoryContactLoaderCacheTests: XCTestCase {

    func test_load_contacts_on_first_access() {
        var loaderCalled = false
        let expectation = expectation(description: "Load called")
        let sut = InMemoryContactLoaderCache { _ in
            loaderCalled = true
            expectation.fulfill()
        }
        sut.load { _ in }
        wait(for: [expectation])
        XCTAssertTrue(loaderCalled)
    }

    func test_only_has_one_active_request() {
        var loadCount = 0
        let sut = InMemoryContactLoaderCache { completion in
            loadCount += 1
            completion([])
        }

        let expectation = expectation(description: "Load called")
        sut.load { _ in
            expectation.fulfill()
            sleep(10)
        }
        sut.load { _ in }
        sut.load { _ in }

        wait(for: [expectation])
        XCTAssertEqual(loadCount, 1)
    }

    func test_returns_received_contacts_on_completion() {
        let testContacts = [
            ContactViewModel(name: "Jane Doe", contactMethod: .email),
            ContactViewModel(name: "Clark Kent", contactMethod: .post)
        ]
        var receivedContacs: [ContactViewModel] = []
        let expectation = expectation(description: "Load called")
        let sut = InMemoryContactLoaderCache { completion in
            completion(testContacts)
            expectation.fulfill()
        }
        sut.load { contacts in receivedContacs = contacts }
        wait(for: [expectation])
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
        let expectation = expectation(description: "Load called")
        sut.load { contacts in
            receivedContacs = contacts
            expectation.fulfill()
        }
        wait(for: [expectation])
        XCTAssertEqual(receivedContacs, testContacts)
    }
}
