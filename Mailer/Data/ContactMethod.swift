//
//  ContactMethod.swift
//  Mailer
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import Foundation

enum ContactMethod {
    case email, post, sms
    
    var title: String {
        switch self {
        case .email:
            "eMail"
        default:
            ""
        }
    }
}
