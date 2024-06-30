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
        reader.open(path: filePath)
        _ = reader.readNextRow()
        reader.close()
    }
}

final class ContactLoaderTests: XCTestCase {

    func test_perform_actions_in_correct_order() {
        let spyReader = ReaderSpy()
        let dummyPath = "SomeRandomFilePath"
        let sut = ContactLoader(filePath: dummyPath, reader: spyReader)
        sut.load()
        XCTAssertEqual(spyReader.calledActions, [.open(dummyPath), .readRow, .close])
    }

    // MARK: Helpers

    private final class ReaderSpy: CSVReading {

        enum Actions: Equatable {
            case open(String)
            case readRow, close
        }

        private(set) var calledActions: [Actions] = []

        func open(path: String) {
            calledActions.append(.open(path))
        }

        func readNextRow() -> [Substring]? {
            calledActions.append(.readRow)
            return nil
        }

        func close() {
            calledActions.append(.close)
        }
    }
}
