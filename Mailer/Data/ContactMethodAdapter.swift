//
//  ContactMethodAdapter.swift
//  Mailer
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import Foundation

enum ContactMethodAdapter {
    private static let separator = "|"

    static func method(from address: String) -> ContactMethod {
        guard let country = address.components(separatedBy: separator).last else { return .sms }
        switch country {
        case "Saint Lucia", "Czech Republic":
            return .email
        case "Italy", "Australia", "Finland":
            return .post
        default:
            return .sms
        }
    }
}
