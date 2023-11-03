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
        let sut = ContactService(csvReader: reader)
        sut.loadContacts()
        XCTAssertTrue(reader.openCalled)
    }

    private final class FakeCSVReader: NSObject, CSVReading {

        private(set) var openCalled = false

        func readNextRow() -> [Substring]? {
            nil
        }
        
        func open(path: String) {
            openCalled = true
        }
        
        func close() { }
    }
}
