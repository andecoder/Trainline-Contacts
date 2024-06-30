//
//  ContactMethodTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactMethodTests: XCTestCase {

    func test_title_for_email() {
        XCTAssertEqual(ContactMethod.email.title, "eMail")
    }
}
