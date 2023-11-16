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
        _ = makeSUT(contactMethod: .post, view: view)
        XCTAssertEqual(view.setTitleValue, "Post")
    }

    func test_set_view_title_correctly_for_sms() {
        let view = DetailsViewSpy()
        _ = makeSUT(contactMethod: .sms, view: view)
        XCTAssertEqual(view.setTitleValue, "SMS")
    }

    func test_set_view_title_correctly_for_email() {
        let view = DetailsViewSpy()
        _ = makeSUT(contactMethod: .email, view: view)
        XCTAssertEqual(view.setTitleValue, "e-mail")
    }

    // MARK: Helpers

    private func makeSUT(
        contactMethod: ContactMethod,
        view: DetailsViewSpy,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> DetailsPresenter {
        let sut = DetailsPresenter(contactMethod: contactMethod, view: view)
        sut.viewIsReady()
        checkForMemoryLeak(on: view, file: file, line: line)
        return sut
    }

    private final class DetailsViewSpy: DetailsView {

        private(set) var setTitleValue: String?

        func display(_: [String]) { }

        func setTitle(to title: String) {
            setTitleValue = title
        }
    }
}
