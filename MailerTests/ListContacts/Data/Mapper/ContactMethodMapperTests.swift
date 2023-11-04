//
//  ContactMethodMapperTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 04/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactMethodMapperTests: XCTestCase {

    func test_map_returns_email_when_country_is_czech_republic() {
        let sut = ContactMethodMapper()
        let method = sut.map(address: "An address|in|Czech Republic")
        XCTAssertEqual(method, .email)
    }

    func test_map_returns_email_when_country_is_saint_lucia() {
        let sut = ContactMethodMapper()
        let method = sut.map(address: "An address|in|Saint Lucia")
        XCTAssertEqual(method, .email)
    }

    func test_map_returns_post_when_country_is_italy() {
        let sut = ContactMethodMapper()
        let method = sut.map(address: "An address|in|Italy")
        XCTAssertEqual(method, .post)
    }

    func test_map_returns_post_when_country_is_australia() {
        let sut = ContactMethodMapper()
        let method = sut.map(address: "An address|in|Australia")
        XCTAssertEqual(method, .post)
    }

    func test_map_returns_post_when_country_is_finland() {
        let sut = ContactMethodMapper()
        let method = sut.map(address: "An address|in|Finland")
        XCTAssertEqual(method, .post)
    }

    func test_map_returns_sms_for_any_other_value() {
        let sut = ContactMethodMapper()
        let method = sut.map(address: "An invalid|Country")
        XCTAssertEqual(method, .sms)
    }
}
