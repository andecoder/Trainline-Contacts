//
//  ContactMethodAdapterTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

enum ContactMethod {
    case sms
}

enum ContactMethodAdapter {
    static func method(from address: String) -> ContactMethod {
        .sms
    }
}

final class ContactMethodAdapterTests: XCTestCase {

    func test_method_is_sms_for_other_countries() {
        let fullAddress = "street|city|state|postcode|Portugal"
        let contactMethod = ContactMethodAdapter.method(from: fullAddress)
        XCTAssertEqual(contactMethod, .sms)
    }
}
