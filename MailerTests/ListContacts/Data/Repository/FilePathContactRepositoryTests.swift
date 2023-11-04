//
//  FilePathContactRepositoryTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 04/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class FilePathContactRepositoryTests: XCTestCase {

    func test_contacts_interacts_with_reader_in_correct_order() {
        let reader = FakeCSVReader()
        let filePath = "somePathLocation"
        let sut = makeSUT(path: filePath, reader: reader)
        _ = sut.contacts
        let expectedInteractions: [FakeCSVReader.Interaction] = [
            .open(filePath), .readRow, .readRow, .close
        ]
        XCTAssertEqual(reader.interactions, expectedInteractions)
    }

    func test_contacts_interacts_with_reader_only_once() {
        let reader = FakeCSVReader()
        let filePath = "somePathLocation"
        let sut = makeSUT(path: filePath, reader: reader)
        _ = sut.contacts
        _ = sut.contacts
        let expectedInteractions: [FakeCSVReader.Interaction] = [
            .open(filePath), .readRow, .readRow, .close
        ]
        XCTAssertEqual(reader.interactions, expectedInteractions)
    }

    func test_contacts_returns_empty_list_when_file_is_empty() {
        let reader = FakeCSVReader(readNextRowReturn: [])
        let sut = makeSUT(reader: reader)
        XCTAssertTrue(sut.contacts.isEmpty)
    }

    func test_contacts_returns_correct_contacts() {
        let reader = FakeCSVReader(readNextRowReturn: [
            ["John Appleseed", "Hertfordshire|Finland"]
        ])
        let sut = makeSUT(reader: reader)
        let expectedContact = Contact(name: "John Appleseed", contactMethod: "SMS")
        XCTAssertEqual(sut.contacts, [expectedContact])
    }

    // MARK: Helpers

    private func makeSUT(
        path: String = "DUMMY",
        reader: FakeCSVReader = FakeCSVReader(),
        file: StaticString = #filePath,
        line: UInt = #line,
        mapper: @escaping (String) -> ContactMethod = { _ in .sms }
    ) -> FilePathContactRepository {
        let sut = FilePathContactRepository(csvReader: reader, filePath: path, mapper: mapper)
        checkForMemoryLeak(on: reader, file: file, line: line)
        checkForMemoryLeak(on: sut, file: file, line: line)
        return sut
    }

    private final class FakeCSVReader: NSObject, CSVReading {

        enum Interaction: Equatable {
            case open(String)
            case readRow, close
        }

        private(set) var interactions: [Interaction] = []
        private var readNextRowReturn: [[Substring]]

        init(readNextRowReturn: [[Substring]] = [["Name", "Address"]]) {
            self.readNextRowReturn = readNextRowReturn
        }

        func readNextRow() -> [Substring]? {
            interactions.append(.readRow)
            if readNextRowReturn.isEmpty {
                return nil
            } else {
                return readNextRowReturn.removeFirst()
            }
        }

        func open(path: String) {
            interactions.append(.open(path))
        }

        func close() {
            interactions.append(.close)
        }
    }
}
