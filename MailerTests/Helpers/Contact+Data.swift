//
//  Contact+Data.swift
//  MailerTests
//
//  Created by Anderson Costa on 02/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

@testable import Mailer

extension Contact {
    static let dummyData: [Contact] = [
        Contact(name: "John Appleseed", contactMethod: "Post"),
        Contact(name: "Velma Combs", contactMethod: "e-Mail"),
        Contact(name: "Porter Coffey", contactMethod: "SMS")
    ]
}

extension Contact: Equatable {

    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name == rhs.name && lhs.contactMethod == rhs.contactMethod
    }
}
