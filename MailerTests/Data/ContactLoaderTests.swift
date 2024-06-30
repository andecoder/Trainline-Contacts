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
    private let reader: CSVReading

    init(filePath: String, reader: CSVReading) {
        self.filePath = filePath
        self.reader = reader
    }

    func load() {
        reader.close()
        _ = reader.readNextRow()
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

    func test_load_closes_file_when_done() {
        let spyReader = ReaderSpy()
        let sut = ContactLoader(filePath: "DUMMY", reader: spyReader)
        sut.load()
        XCTAssertTrue(spyReader.closeCalled)
    }

    func test_load_read_rows() {
        let spyReader = ReaderSpy()
        let sut = ContactLoader(filePath: "DUMMY", reader: spyReader)
        sut.load()
        XCTAssertTrue(spyReader.readNextRowCalled)
    }

    // MARK: Helpers

    private final class ReaderSpy: CSVReading {

        private(set) var closeCalled = false
        private(set) var openedFile: String?
        private(set) var readNextRowCalled = false

        func open(path: String) {
            openedFile = path
        }

        func readNextRow() -> [Substring]? {
            readNextRowCalled = true
            return nil
        }

        func close() {
            closeCalled = true
        }
    }
}
