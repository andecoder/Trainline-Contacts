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
        sut.loadContacts { _ in }
        let expectedInteractions: [FakeCSVReader.Interaction] = [
            .open(filePath), .readRow, .readRow, .close
        ]
        XCTAssertEqual(reader.interactions, expectedInteractions)
    }

    func test_loadContacts_returns_empty_list_when_file_is_empty() {
        let reader = FakeCSVReader()
        reader.readNextRowReturn = []
        let sut = ContactService(csvReader: reader, filePath: "DUMMY")
        var expectedContacts: [Contact]?
        sut.loadContacts() { expectedContacts = $0 }
        XCTAssertEqual(expectedContacts, [])
    }

    func test_loadContacts_returns_correct_contacts() {
        let reader = FakeCSVReader()
        reader.readNextRowReturn = [
            ["John Appleseed", "Hertfordshire|Finland"],
            ["Velma Combs", "306 Rhoncus. St.|Czech Republic"],
            ["Porter Coffey", "Palo Alto|Cameroon"]
        ]
        let sut = ContactService(csvReader: reader, filePath: "DUMMY")
        var expectedContacts: [Contact]?
        sut.loadContacts() { expectedContacts = $0 }
        XCTAssertEqual(expectedContacts, Contact.dummyData)
    }

    private final class FakeCSVReader: NSObject, CSVReading {

        enum Interaction: Equatable {
            case open(String)
            case readRow, close
        }

        private(set) var interactions: [Interaction] = []
        var readNextRowReturn: [[Substring]] = [["Name", "Address"]]

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
