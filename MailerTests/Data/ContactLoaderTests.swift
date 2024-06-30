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
        let spyReader = ReaderSpy()
        let dummyPath = "SomeRandomFilePath"
        let sut = ContactLoader(filePath: dummyPath, reader: spyReader)
        sut.load { _ in }
        XCTAssertEqual(spyReader.calledActions, [.open(dummyPath), .readRow, .close])
    }

    func test_keeps_reading_while_there_are_rows() {
        let spyReader = ReaderSpy(rows: [["A"], ["B"], ["C"]])
        let dummyPath = "SomeRandomFilePath"
        let sut = ContactLoader(filePath: dummyPath, reader: spyReader)
        sut.load { _ in }
        XCTAssertEqual(
            spyReader.calledActions,
            [.open(dummyPath), .readRow, .readRow, .readRow, .readRow, .close])
    }

    func test_returns_valid_contacts() {
        let contact: [Substring] = ["John Doe", "A random address", "07543265478", "j.doe@people.com"]
        let spyReader = ReaderSpy(rows: [contact])
        var receivedContacts: [Contact] = []
        let sut = ContactLoader(filePath: "DUMMY", reader: spyReader)
        sut.load { contacts in
            receivedContacts = contacts
        }
        XCTAssertEqual(receivedContacts, [.johnDoe])
    }

    // MARK: Helpers

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

private extension Contact {

    static let johnDoe = Contact(
        fullName: "John Doe",
        address: "A random address",
        phoneNumber: "07543265478",
        email: "j.doe@people.com"
    )
}
