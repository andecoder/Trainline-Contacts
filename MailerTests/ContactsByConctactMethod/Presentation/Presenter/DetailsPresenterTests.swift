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

    func test_display_contact_names_when_request_succeeds() {
        let view = DetailsViewSpy()
        _ = makeSUT(view: view)
        let expectedNames = ["John Appleseed", "Velma Combs", "Porter Coffey"]
        XCTAssertEqual(view.displayedList, expectedNames)
    }

    // MARK: Helpers

    private func makeSUT(
        contactMethod: ContactMethod = .post,
        service: ContactLoaderServiceMock = ContactLoaderServiceMock(),
        view: DetailsViewSpy,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> DetailsPresenter {
        let sut = DetailsPresenter(contactMethod: contactMethod, service: service, view: view)
        sut.viewIsReady()
        checkForMemoryLeak(on: service, file: file, line: line)
        checkForMemoryLeak(on: view, file: file, line: line)
        return sut
    }

    private final class DetailsViewSpy: DetailsView {

        private(set) var displayedList: [String]?
        private(set) var setTitleValue: String?

        func display(_ contacts: [String]) {
            displayedList = contacts
        }

        func setTitle(to title: String) {
            setTitleValue = title
        }
    }
}
