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

    init(loadContacts: @escaping () -> Void) {
        self.loadContacts = loadContacts
    }

    func load() {
        loadContacts()
    }
}

final class InMemoryContactLoaderCacheTests: XCTestCase {

    func test_load_contacts_on_first_access() {
        var loaderCalled = false
        let sut = InMemoryContactLoaderCache { loaderCalled = true }
        sut.load()
        XCTAssertTrue(loaderCalled)
    }
}
