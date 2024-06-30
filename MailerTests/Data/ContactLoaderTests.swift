//
//  ContactLoaderTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactLoaderTests: XCTestCase {

    func test_perform_actions_in_correct_order() {
        let dummyPath = "SomeRandomFilePath"
        let spyReader = load(path: dummyPath)
        XCTAssertEqual(spyReader.calledActions, [.open(dummyPath), .readRow, .close])
    }

    func test_keeps_reading_while_there_are_rows() {
        let dummyPath = "SomeRandomFilePath"
        let spyReader = load(path: dummyPath, rows: [["A"], ["B"], ["C"]])
        XCTAssertEqual(
            spyReader.calledActions,
            [.open(dummyPath), .readRow, .readRow, .readRow, .readRow, .close]
        )
    }

    func test_returns_valid_contacts() {
        let contact: [Substring] = ["John Doe", "A random address", "07543265478", "j.doe@people.com"]
        var receivedContacts: [Contact] = []
        _ = load(rows: [contact]) { contacts in receivedContacts = contacts }
        XCTAssertEqual(receivedContacts, [.johnDoe])
    }

    // MARK: Helpers

    private func load(path: String = "DUMMY", rows: [[Substring]] = [], onLoad: @escaping ([Contact]) -> Void = { _ in }) -> ReaderSpy {
        let reader = ReaderSpy(rows: rows)
        let sut = ContactLoader(filePath: path, reader: reader)
        sut.load(completion: onLoad)
        return reader
    }

    private final class ReaderSpy: CSVReading {

        enum Actions: Equatable {
            case open(String)
            case readRow, close
        }

        private(set) var calledActions: [Actions] = []
        private var rows: [[Substring]]

        init(rows: [[Substring]] = []) {
            self.rows = rows
        }

        func open(path: String) {
            calledActions.append(.open(path))
        }

        func readNextRow() -> [Substring]? {
            calledActions.append(.readRow)
            guard !rows.isEmpty else { return nil }
            return rows.removeFirst()
        }

        func close() {
            calledActions.append(.close)
        }
    }
}
