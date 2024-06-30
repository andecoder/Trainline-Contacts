//
//  ContactViewModelAdapterTests.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

@testable import Mailer

enum ContactViewModelAdapter {
    static func adapt(
        load: @escaping (([Contact]) -> Void) -> Void,
        contactMethodMapper: @escaping (String) -> ContactMethod
    ) -> (([ContactViewModel]) -> Void) -> Void {
        { completion in
            load { contacts in
                let viewModels = contacts.map { contact -> ContactViewModel in
                    let contactMethod = contactMethodMapper(contact.address)
                    return ContactViewModel(name: contact.fullName, contactMethod: contactMethod)
                }
                completion(viewModels)
            }
        }
    }
}

final class ContactViewModelAdapterTests: XCTestCase {

    func test_adapted_returns_view_models_for_each_character_received() {
        let load: (([Contact]) -> Void) -> Void = { completion in completion([.johnDoe]) }
        let adapted = ContactViewModelAdapter.adapt(load: load) { _ in .post }
        var receivedViewModels: [ContactViewModel] = []
        adapted { viewModels in receivedViewModels = viewModels }
        XCTAssertEqual(receivedViewModels, [ContactViewModel(name: "John Doe", contactMethod: .post)])
    }
}
