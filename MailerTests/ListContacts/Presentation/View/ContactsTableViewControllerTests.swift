//
//  ContactsTableViewControllerTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 31/10/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

final class ContactsTableViewControllerTests: XCTestCase {

    func test_has_no_contacts_when_view_loads() {
        let sut = makeSUT()
        sut.hasNoContacts()
    }

    func test_display_correct_contact_information() {
        let sut = makeSUT()

        let contacts: [ContactCellViewModel] = ContactCellViewModel.dummyData
        sut.display(contacts)

        sut.isDisplaying(contacts)
    }

    func test_only_load_contacts_once_when_view_loads() {
        let useCase = LoadContactsUseCaseSpy()
        let sut = makeSUT(useCase: useCase)
        sut.loadViewIfNeeded()
        XCTAssertEqual(useCase.loadContactsCount, 1)
    }

    func test_closure_receives_viewModel_of_selected_cell() {
        var receivedViewModels: [ContactCellViewModel] = []
        let sut = makeSUT { receivedViewModels.append($0) }
        sut.display(ContactCellViewModel.dummyData)
        sut.selectCell(atIndex: 1)
        let expectedViewModel = ContactCellViewModel(name: "Velma Combs", contactMethod: "e-mail")
        XCTAssertEqual(receivedViewModels, [expectedViewModel])
    }

    // MARK: Helpers

    private func makeSUT(
        useCase: LoadContactsUseCase = LoadContactsUseCaseSpy(),
        file: StaticString = #filePath,
        line: UInt = #line,
        didSelect: @escaping (ContactCellViewModel) -> Void = { _ in }
    ) -> ContactsTableViewController {
        let sut = ContactsTableViewController(useCase: useCase, didSelect: didSelect)
        checkForMemoryLeak(on: sut, file: file, line: line)
        return sut
    }

    private final class LoadContactsUseCaseSpy: LoadContactsUseCase {

        private(set) var loadContactsCount = 0

        func loadContacts() {
            loadContactsCount += 1
        }
    }
}

private extension ContactsTableViewController {

    func hasNoContacts(file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(tableView(tableView, numberOfRowsInSection: 0), 0, file: file, line: line)
    }

    func isDisplaying(_ contacts: [ContactCellViewModel], file: StaticString = #filePath, line: UInt = #line) {
        contacts.enumerated().forEach { (index, contact) in
            isDisplaying(contact, atIndex: index, file: file, line: line)
        }
    }

    func selectCell(atIndex index: Int) {
        tableView(tableView, didSelectRowAt: IndexPath(row: index, section: 0))
    }

    private func isDisplaying(_ contact: ContactCellViewModel, atIndex index: Int, file: StaticString, line: UInt) {
        let row = tableView(tableView, cellForRowAt: IndexPath(row: index, section: 0))
        XCTAssertEqual(row.textLabel?.text, contact.name, file: file, line: line)
        XCTAssertEqual(row.detailTextLabel?.text, contact.contactMethod, file: file, line: line)
    }
}
