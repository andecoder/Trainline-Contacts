//
//  InMemoryContactLoaderCacheTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

final class InMemoryContactLoaderCache {

    private let loadContacts: () -> Void
    private var loadCalled = false

    init(loadContacts: @escaping () -> Void) {
        self.loadContacts = loadContacts
    }

    func load() {
        guard !loadCalled else { return }
        loadContacts()
        loadCalled = true
    }
}

final class InMemoryContactLoaderCacheTests: XCTestCase {

    func test_load_contacts_on_first_access() {
        var loaderCalled = false
        let sut = InMemoryContactLoaderCache { loaderCalled = true }
        sut.load()
        XCTAssertTrue(loaderCalled)
    }

    func test_read_from_cache_on_subsequent_access() {
        var loadCount = 0
        let sut = InMemoryContactLoaderCache { loadCount += 1 }

        sut.load()
        sut.load()
        sut.load()

        XCTAssertEqual(loadCount, 1)
    }
}
