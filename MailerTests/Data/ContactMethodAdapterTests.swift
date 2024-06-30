//
//  ContactMethodAdapterTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

enum ContactMethod {
    case email, sms
}

enum ContactMethodAdapter {
    private static let separator = "|"

    static func method(from address: String) -> ContactMethod {
        guard let country = address.components(separatedBy: separator).last else { return .sms }
        if country == "Saint Lucia" {
            return .email
        }
        return .sms
    }
}

final class ContactMethodAdapterTests: XCTestCase {

    func test_method_is_email_for_saint_lucia() {
        let fullAddress = "street|city|state|postcode|Saint Lucia"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .email)
    }

    func test_method_is_sms_for_other_countries() {
        let fullAddress = "street|city|state|postcode|Portugal"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .sms)
    }
}
