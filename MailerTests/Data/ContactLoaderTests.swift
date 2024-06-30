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
   
    private let filePath: String
    private let reader: StreamOpenable

    init(filePath: String, reader: StreamOpenable) {
        self.filePath = filePath
        self.reader = reader
    }

    func load() {
        reader.open(path: filePath)
    }
}

final class ContactLoaderTests: XCTestCase {

    func test_load_opens_correct_file() {
        let spyReader = ReaderSpy()
        let dummyPath = "SomeRandomFilePath"
        let sut = ContactLoader(filePath: dummyPath, reader: spyReader)
        sut.load()
        XCTAssertEqual(spyReader.openedFile, dummyPath)
    }

    // MARK: Helpers

    private final class ReaderSpy: StreamOpenable {

        private(set) var openedFile: String?

        func open(path: String) {
            openedFile = path
        }
    }
}
