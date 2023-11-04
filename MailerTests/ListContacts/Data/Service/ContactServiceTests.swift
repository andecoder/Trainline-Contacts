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
        XCTAssertEqual(reader.interactions, [.open(filePath), .close])
    }

    private final class FakeCSVReader: NSObject, CSVReading {

        enum Interaction: Equatable {
            case open(String)
            case close
        }

        private(set) var interactions: [Interaction] = []

        func readNextRow() -> [Substring]? {
            nil
        }
        
        func open(path: String) {
            interactions.append(.open(path))
        }
        
        func close() {
            interactions.append(.close)
        }
    }
}
