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
            ContactViewModel(name: "Shelby Macias", contactMethod: .post),
            ContactViewModel(name: "Porter Coffey", contactMethod: .post),
            ContactViewModel(name: "Noelani Ward", contactMethod: .email),
            ContactViewModel(name: "Lillian Cotton", contactMethod: .sms),
            ContactViewModel(name: "Ursa Faulkner", contactMethod: .email),
            ContactViewModel(name: "Cailin Mckinney", contactMethod: .post),
            ContactViewModel(name: "Heidi Lawson", contactMethod: .sms),
            ContactViewModel(name: "Mariam Madden", contactMethod: .sms),
            ContactViewModel(name: "Velma Combs", contactMethod: .email)
        ]
        let sut = ContactsTableViewController(
            displayDetails: { _ in }, loadContacts: { completion in completion(dummyContacts) }
        )

        let navController = UINavigationController(rootViewController: sut)
        navController.navigationBar.prefersLargeTitles = true
        assertSnapshot(of: navController, as: .image)
    }

    func test_details_screen() {
        let names = ["Shelby Macias", "Noelani Ward", "Ursa Faulkner", "Heidi Lawson", "Velma Combs"]
        let sut = DetailsTableViewController(title: "SMS", loadContacts: { completion in completion(names) })
        let navController = UINavigationController()
        navController.setViewControllers([UIViewController(), sut], animated: false)

        assertSnapshot(of: navController, as: .image)
    }
}
