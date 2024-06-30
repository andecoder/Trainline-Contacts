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
        _ = makeSUT { _ in didLoadContacts = true }

        XCTAssertTrue(didLoadContacts)
    }

    func test_table_is_empty_when_view_loads() {
        let sut = makeSUT()

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }

    func test_display_contacts_when_request_succeeds() {
        let sut = makeSUT(loadContacts: { completion in
            let names = ["DUMMY", "DUMMY", "DUMMY"]
            completion(names)
        })

        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }

    // MARK: Helpers

    private func makeSUT(
        title: String = "DUMMY",
        loadContacts: @escaping DetailsTableViewController.LoadContacts = { _ in }
    ) -> DetailsTableViewController {
        let viewController = DetailsTableViewController(title: title, loadContacts: loadContacts)
        viewController.loadViewIfNeeded()
        trackMemoryLeaks(on: viewController)
        return viewController
    }
}
