//
//  ContactLoaderTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

struct ContactLoader {
    private let reader: StreamOpenable

    init(reader: StreamOpenable) {
        self.reader = reader
    }

    func load() {
        reader.open(path: "")
    }
}

final class ContactLoaderTests: XCTestCase {

    func test_load_opens_file() {
        let spyReader = ReaderSpy()
        let sut = ContactLoader(reader: spyReader)
        sut.load()
        XCTAssertTrue(spyReader.openCalled)
    }

    // MARK: Helpers

    private final class ReaderSpy: StreamOpenable {

        private(set) var openCalled = false

        func open(path: String) {
            openCalled = true
        }
    }
}
