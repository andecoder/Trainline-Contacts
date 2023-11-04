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

    func test_loadContacts_interacts_with_reader_in_correct_order() {
        let reader = FakeCSVReader()
        let filePath = "somePathLocation"
        let sut = ContactService(csvReader: reader, filePath: filePath)
        sut.loadContacts()
        let expectedInteractions: [FakeCSVReader.Interaction] = [
            .open(filePath), .readRow, .readRow, .close
        ]
        XCTAssertEqual(reader.interactions, expectedInteractions)
    }

    private final class FakeCSVReader: NSObject, CSVReading {

        enum Interaction: Equatable {
            case open(String)
            case readRow, close
        }

        private(set) var interactions: [Interaction] = []
        private(set) var readNextRowCalled = false
        private(set) var readNextRowCallCount = 0
        private var readNextRowReturn: [[Substring]] = [["Name", "Address"]]

        func readNextRow() -> [Substring]? {
            interactions.append(.readRow)
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
