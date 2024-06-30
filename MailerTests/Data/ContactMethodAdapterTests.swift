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
        let fullAddress = "street|city|state|postcode|Czech Republic"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .email)
    }

    func test_method_is_email_for_saint_lucia() {
        let fullAddress = "street|city|state|postcode|Saint Lucia"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .email)
    }

    func test_method_is_post_for_italy() {
        let fullAddress = "street|city|state|postcode|Italy"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .post)
    }

    func test_method_is_post_for_australia() {
        let fullAddress = "street|city|state|postcode|Australia"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .post)
    }

    func test_method_is_post_for_finland() {
        let fullAddress = "street|city|state|postcode|Finland"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .post)
    }

    func test_method_is_sms_for_other_countries() {
        let fullAddress = "street|city|state|postcode|Portugal"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .sms)
    }
}
