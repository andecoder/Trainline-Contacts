//
//  ContactMethodAdapterTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactMethodAdapterTests: XCTestCase {

    func test_method_is_email_for_czech_republic() {
        expect(.email, fromCountry: "Czech Republic")
    }

    func test_method_is_email_for_saint_lucia() {
        expect(.email, fromCountry: "Saint Lucia")
    }

    func test_method_is_post_for_italy() {
        expect(.post, fromCountry: "Italy")
    }

    func test_method_is_post_for_australia() {
        expect(.post, fromCountry: "Australia")
    }

    func test_method_is_post_for_finland() {
        expect(.post, fromCountry: "Finland")
    }

    func test_method_is_sms_for_other_countries() {
        expect(.sms, fromCountry: "Portugal")
    }

    // MARK: Helpers

    private func expect(_ contactMethod: ContactMethod, fromCountry country: String, file: StaticString = #filePath, line: UInt = #line) {
        let fullAddress = "street|city|state|postcode|\(country)"
        let receivedContactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(receivedContactMethod, contactMethod)
    }
}
