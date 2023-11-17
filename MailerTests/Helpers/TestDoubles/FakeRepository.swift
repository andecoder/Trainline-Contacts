//
//  FakeRepository.swift
//  MailerTests
//
//  Created by Anderson Costa on 17/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

@testable import Mailer

final class FakeRepository: ContactRepository {
    let contacts: [Contact] = Contact.dummyData
}
