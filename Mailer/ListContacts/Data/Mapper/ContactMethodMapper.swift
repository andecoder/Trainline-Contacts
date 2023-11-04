//
//  ContactMethodMapper.swift
//  Mailer
//
//  Created by Anderson Costa on 04/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

struct ContactMethodMapper {
    func map(address: String) -> ContactMethod {
        if address.components(separatedBy: "|").last == "Italy" {
            return .post
        }
        return .email
    }
}
