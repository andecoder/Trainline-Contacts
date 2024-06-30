//
//  DetailsTableViewControllerTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class DetailsTableViewControllerTests: XCTestCase {

    func test_set_title_when_created() {
        let title = "My Custom Title"
        let sut = makeSUT(title: title)
        XCTAssertEqual(sut.title, title)
    }

    func test_fetch_contacts_on_load() {
        var didLoadContacts: Bool = false
        let sut = makeSUT { didLoadContacts = true }

        sut.loadViewIfNeeded()

        XCTAssertTrue(didLoadContacts)
    }

    // MARK: Helpers

    private func makeSUT(
        title: String = "DUMMY",
        loadContacts: @escaping DetailsTableViewController.LoadContacts = { }
    ) -> DetailsTableViewController {
        let viewController = DetailsTableViewController(title: title, loadContacts: loadContacts)
        viewController.loadViewIfNeeded()
        return viewController
    }
}
