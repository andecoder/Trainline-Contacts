//
//  DetailsTableViewControllerTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 15/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class DetailsTableViewControllerTests: XCTestCase {

    func test_title_is_correct_for_post() {
        let sut = DetailsTableViewController(contactMethod: .post)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Post")
    }

    func test_title_is_correct_for_sms() {
        let sut = DetailsTableViewController(contactMethod: .sms)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "SMS")
    }

    func test_title_is_correct_for_email() {
        let sut = DetailsTableViewController(contactMethod: .email)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "e-mail")
    }
}
