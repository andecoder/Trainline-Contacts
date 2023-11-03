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

    func test_loadContacts_open_file() {
        let reader = FakeCSVReader()
        let sut = ContactService(csvReader: reader, filePath: "DUMMY")
        sut.loadContacts()
        XCTAssertTrue(reader.openCalled)
    }

    func test_loadContacts_opens_correct_file() {
        let reader = FakeCSVReader()
        let filePath = "somePathLocation"
        let sut = ContactService(csvReader: reader, filePath: filePath)
        sut.loadContacts()
        XCTAssertEqual(reader.openPathArg, filePath)
    }

    private final class FakeCSVReader: NSObject, CSVReading {

        private(set) var openCalled = false
        private(set) var openPathArg: String?

        func readNextRow() -> [Substring]? {
            nil
        }
        
        func open(path: String) {
            openCalled = true
            openPathArg = path
        }
        
        func close() { }
    }
}
