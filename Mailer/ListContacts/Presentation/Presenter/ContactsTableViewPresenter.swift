//
//  ContactsTableViewPresenter.swift
//  Mailer
//
//  Created by Anderson Costa on 31/10/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

final class ContactsTableViewPresenter {

    private let mapper: ([Contact]) -> [ContactCellViewModel]
    private let service: ContactLoaderService
    private let view: ContactListView

    init(
        service: ContactLoaderService,
        view: ContactListView,
        mapper: @escaping ([Contact]) -> [ContactCellViewModel]
    ) {
        self.mapper = mapper
        self.service = service
        self.view = view
    }

    func loadContacts() {
        service.loadContacts { result in
            if case let .success(contacts) = result {
                _ = self.mapper(contacts)
            }
            self.view.display([])
    }
}
