//
//  ContactMethodContactLoaderServiceDecorator.swift
//  Mailer
//
//  Created by Anderson Costa on 17/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

final class ContactMethodContactLoaderServiceDecorator: ContactLoaderService {

    private let contactMethod: ContactMethod
    private let repository: ContactRepository

    init(contactMethod: ContactMethod, repository: ContactRepository) {
        self.contactMethod = contactMethod
        self.repository = repository
    }

    func loadContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        let contacts = repository.contacts
            .filter { $0.contactMethod == contactMethod }
        completion(.success(contacts))
    }
}
