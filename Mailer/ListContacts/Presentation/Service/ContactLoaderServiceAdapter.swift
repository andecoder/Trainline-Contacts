//
//  ContactLoaderServiceAdapter.swift
//  Mailer
//
//  Created by Anderson Costa on 03/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

final class ContactLoaderServiceAdapter: ContactLoaderService {

    private let repository: ContactRepository

    init(repository: ContactRepository) {
        self.repository = repository
    }

    func loadContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        let contacts = repository.contacts
        completion(.success(contacts))
    }
}
