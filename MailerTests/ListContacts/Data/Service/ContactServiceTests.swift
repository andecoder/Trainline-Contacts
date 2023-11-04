//
//  ContactServiceTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 03/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactServiceTests: XCTestCase {

    func test_loadContacts_tries_to_read_row_from_file() {
        let reader = FakeCSVReader()
        let sut = ContactService(csvReader: reader, filePath: "DUMMY")
        sut.loadContacts()
        XCTAssertTrue(reader.readNextRowCalled)
    }

    func test_loadContacts_reads_all_rows_from_file() {
        let reader = FakeCSVReader()
        let sut = ContactService(csvReader: reader, filePath: "DUMMY")
        sut.loadContacts()
        XCTAssertEqual(reader.readNextRowCallCount, 2)
    }

    func test_loadContacts_interacts_with_reader_in_correct_order() {
        let reader = FakeCSVReader()
        let filePath = "somePathLocation"
        let sut = ContactService(csvReader: reader, filePath: filePath)
        sut.loadContacts()
        XCTAssertEqual(reader.interactions, [.open(filePath), .close])
    }

    private final class FakeCSVReader: NSObject, CSVReading {

        enum Interaction: Equatable {
            case open(String)
            case close
        }

        private(set) var interactions: [Interaction] = []
        private(set) var readNextRowCalled = false
        private(set) var readNextRowCallCount = 0
        private var readNextRowReturn: [[Substring]] = [["Name", "Address"]]

        func readNextRow() -> [Substring]? {
            readNextRowCalled = true
            readNextRowCallCount += 1
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
