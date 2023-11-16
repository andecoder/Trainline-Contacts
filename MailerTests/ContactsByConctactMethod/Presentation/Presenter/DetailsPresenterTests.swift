//
//  DetailsPresenterTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 16/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class DetailsPresenterTests: XCTestCase {

    func test_set_view_title_correctly_for_post() {
        let view = DetailsViewSpy()
        let sut = DetailsPresenter(contactMethod: .post, view: view)
        sut.viewIsReady()
        XCTAssertEqual(view.setTitleValue, "Post")
    }

    func test_set_view_title_correctly_for_sms() {
        let view = DetailsViewSpy()
        let sut = DetailsPresenter(contactMethod: .sms, view: view)
        sut.viewIsReady()
        XCTAssertEqual(view.setTitleValue, "SMS")
    }

    func test_set_view_title_correctly_for_email() {
        let view = DetailsViewSpy()
        let sut = makeSUT(contactMethod: .email, view: view)
        sut.viewIsReady()
        XCTAssertEqual(view.setTitleValue, "e-mail")
    }

    // MARK: Helpers

    private final class DetailsViewSpy: DetailsView {

        private(set) var setTitleValue: String?

        func display(_: [String]) { }

        func setTitle(to title: String) {
            setTitleValue = title
        }
    }
}
