// 
// Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactsPresenterTests: XCTestCase {

    func test_loadContacts_whenCsvReaderReturnsNoValues_viewReceivesEmptyArray() {
        let spyView = ContactsViewSpy()
        let sut = ContactsPresenter()
        sut.bind(spyView)
        sut.loadContacts()
        XCTAssertEqual(spyView.receivedContacts, [])
    }

    func test_loadContacts_whenCsvReaderHasASingleValue_viewReceivesOneElement() {
        let spyView = ContactsViewSpy()
        let sut = ContactsPresenter()
        sut.bind(spyView)
        sut.loadContacts()
        let expectedContact = ContactsCellViewModel(
            fullName: "John Doe",
            marketingMethod: "Post"
        )
        XCTAssertEqual(spyView.receivedContacts, [expectedContact])
    }

    private final class ContactsViewSpy: ContactsView {

        private(set) var receivedContacts: [ContactsCellViewModel]?

        func display(contacts: [ContactsCellViewModel]) {
            receivedContacts = contacts
        }
    }
}

extension ContactsCellViewModel: Equatable {

    public static func ==(lhs: ContactsCellViewModel, rhs: ContactsCellViewModel) -> Bool {
        lhs.fullName == rhs.fullName && lhs.marketingMethod == rhs.marketingMethod
    }
}
