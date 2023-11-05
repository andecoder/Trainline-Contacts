//
//  ContactService.swift
//  Mailer
//
//  Created by Anderson Costa on 03/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

final class ContactService {

    private let repository: ContactRepository

    init(repository: ContactRepository) {
        self.repository = repository
    }

    func loadContacts(completion: @escaping ([Contact]) -> Void) {
        let contacts = repository.contacts
        completion(contacts)
    }
}
