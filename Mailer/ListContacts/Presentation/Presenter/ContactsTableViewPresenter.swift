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
    private let view: ContactListView

    init(service: ContactLoaderService, view: ContactListView) {
        self.service = service
        self.view = view
    }

    func loadContacts() {
        service.loadContacts()
        view.display([])
    }
}
