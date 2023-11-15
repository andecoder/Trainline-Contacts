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
        let sut = makeSUT(contactMethod: .post)
        XCTAssertEqual(sut.title, "Post")
    }

    func test_title_is_correct_for_sms() {
        let sut = makeSUT(contactMethod: .sms)
        XCTAssertEqual(sut.title, "SMS")
    }

    func test_title_is_correct_for_email() {
        let sut = makeSUT(contactMethod: .email)
        XCTAssertEqual(sut.title, "e-mail")
    }

    func test_display_zero_contacts_when_view_loads() {
        let sut = makeSUT()
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
    }

    // MARK: Helpers

    private func makeSUT(
        contactMethod: ContactMethod = .post,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> DetailsTableViewController {
        let sut = DetailsTableViewController(contactMethod: contactMethod)
        sut.loadViewIfNeeded()
        checkForMemoryLeak(on: sut, file: file, line: line)
        return sut
    }
}
