//
//  ContactsTableViewPresenter.swift
//  Mailer
//
//  Created by Anderson Costa on 31/10/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

final class ContactsTableViewPresenter {

    private let service: ContactLoaderService

    init(service: ContactLoaderService) {
        self.service = service
    }

    func loadContacts() {
        service.loadContacts()
    }
}
