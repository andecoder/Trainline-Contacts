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

    func test_loadContacts_opens_correct_file() {
        let reader = FakeCSVReader()
        let filePath = "somePathLocation"
        let sut = ContactService(csvReader: reader, filePath: filePath)
        sut.loadContacts()
        XCTAssertEqual(reader.openPathArg, filePath)
    }

    func test_loadContacts_closes_file_when_finished() {
        let reader = FakeCSVReader()
        let sut = ContactService(csvReader: reader, filePath: "DUMMY")
        sut.loadContacts()
        XCTAssertTrue(reader.closeCalled)
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

        private(set) var closeCalled = false
        private(set) var interactions: [Interaction] = []
        private(set) var openPathArg: String?

        func readNextRow() -> [Substring]? {
            nil
        }
        
        func open(path: String) {
            interactions.append(.open(path))
            openPathArg = path
        }
        
        func close() {
            interactions.append(.close)
            closeCalled = true
        }
    }
}
