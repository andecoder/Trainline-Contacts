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
    static let john = Contact(name: "John Appleseed", contactMethod: .post)
    static let porter = Contact(name: "Porter Coffey", contactMethod: .sms)
    static let velma = Contact(name: "Velma Combs", contactMethod: .email)
    static let dummyData: [Contact] = [john, velma, porter
    ]
}

extension Contact: Equatable {

    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name == rhs.name && lhs.contactMethod == rhs.contactMethod
    }
}
