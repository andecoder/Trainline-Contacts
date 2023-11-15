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
        let sut = DetailsTableViewController()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Post")
    }
}
