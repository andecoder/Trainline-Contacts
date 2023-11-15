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
        sut.hasNoContacts()
    }

    func test_has_same_rows_as_contacts_displayed() {
        let sut = makeSUT()
        sut.display(["Dummy", "Dummy", "Dummy"])
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 3)
    }

    func test_rows_have_correct_text() {
        let sut = makeSUT()
        let contacts = [
            "John Appleseed", "Velma Combs", "Porter Coffey"
        ]
        sut.display(contacts)
        sut.isDisplaying(contacts)
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

private extension DetailsTableViewController {

    func hasNoContacts(file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(
            tableView(tableView, numberOfRowsInSection: 0), 0,
            file: file,
            line: line
        )
    }

    func isDisplaying(_ contacts: [String], file: StaticString = #filePath, line: UInt = #line) {
        contacts.enumerated().forEach { (index, contact) in
            isDisplaying(contact, atIndex: index, file: file, line: line)
        }
    }

    private func isDisplaying(_ contact: String, atIndex index: Int, file: StaticString, line: UInt) {
        let row = tableView(tableView, cellForRowAt: IndexPath(row: index, section: 0))
        XCTAssertEqual(row.textLabel?.text, contact, file: file, line: line)
    }
}
