//
//  MailerSnapshotTests.swift
//  MailerSnapshotTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import SnapshotTesting
import XCTest

@testable import Mailer

// Snapshots recorded with Xcode 15.4 on iPhone 15 Pro, iOS 17.5

final class MailerSnapshotTests: XCTestCase {

    func test_contact_list_screen() {
        let dummyContacts = [
            ContactViewModel(name: "Shelby Macias", contactMethod: "Post"),
            ContactViewModel(name: "Porter Coffey", contactMethod: "Post"),
            ContactViewModel(name: "Noelani Ward", contactMethod: "eMail"),
            ContactViewModel(name: "Lillian Cotton", contactMethod: "SMS"),
            ContactViewModel(name: "Ursa Faulkner", contactMethod: "eMail"),
            ContactViewModel(name: "Cailin Mckinney", contactMethod: "Post"),
            ContactViewModel(name: "Heidi Lawson", contactMethod: "SMS"),
            ContactViewModel(name: "Mariam Madden", contactMethod: "SMS"),
            ContactViewModel(name: "Velma Combs", contactMethod: "eMail")
        ]
        let sut = ContactsTableViewController(
            displayDetails: { _ in }, loadContacts: { completion in completion(dummyContacts) }
        )

        let navController = UINavigationController(rootViewController: sut)
        navController.navigationBar.prefersLargeTitles = true
        assertSnapshot(of: navController, as: .image)
    }
}
