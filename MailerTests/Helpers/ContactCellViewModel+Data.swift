//
//  ContactCellViewModel+Data.swift
//  MailerTests
//
//  Created by Anderson Costa on 31/10/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

@testable import Mailer

extension ContactCellViewModel {
   
    static let dummyData: [ContactCellViewModel] = [
        ContactCellViewModel(name: "John Appleseed", contactMethod: "Post"),
        ContactCellViewModel(name: "Velma Combs", contactMethod: "e-mail"),
        ContactCellViewModel(name: "Porter Coffey", contactMethod: "SMS")
    ]
}

extension ContactCellViewModel: Equatable {

    public static func == (lhs: ContactCellViewModel, rhs: ContactCellViewModel) -> Bool {
        lhs.name == rhs.name && lhs.contactMethod == rhs.contactMethod
    }
}
