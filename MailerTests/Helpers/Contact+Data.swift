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
        Contact(name: "John Appleseed", address: "3027 Lorem St.|Kokomo|Hertfordshire|L9T 3D5|Finland"),
        Contact(name: "Velma Combs", address: "P.O. Box 576, 306 Rhoncus. St.|Sioux City|Fl.|G2N 3Q9|Czech Republic"),
        Contact(name: "Porter Coffey", address: "Ap #827-9064 Sapien. Rd.|Palo Alto|Fl.|HM0G 0YR|Cameroon")
    ]
}

extension Contact: Equatable {

    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name == rhs.name && lhs.address == rhs.address
    }
}
