//
//  ContactMethodMapper.swift
//  Mailer
//
//  Created by Anderson Costa on 04/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

struct ContactMethodMapper {
    private let mapping: [String: ContactMethod] = [
        "Czech Republic": .email,
        "Saint Lucia": .email,
        "Italy": .post,
        "Australia": .post,
        "Finland": .post
    ]

    func map(address: String) -> ContactMethod {
        let country = address.components(separatedBy: "|").last!
        return mapping[country]!
    }
}
