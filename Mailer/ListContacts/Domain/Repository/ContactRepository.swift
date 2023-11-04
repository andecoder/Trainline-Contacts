//
//  ContactRepository.swift
//  Mailer
//
//  Created by Anderson Costa on 04/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

protocol ContactRepository {
    var contacts: [Contact] { get }
}
