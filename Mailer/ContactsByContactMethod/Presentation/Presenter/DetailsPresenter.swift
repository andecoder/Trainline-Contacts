//
//  DetailsPresenter.swift
//  Mailer
//
//  Created by Anderson Costa on 15/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

struct DetailsPresenter {

    private let contactMethod: ContactMethod
    private let service: ContactLoaderService
    private let view: DetailsView

    init(contactMethod: ContactMethod, service: ContactLoaderService, view: DetailsView) {
        self.contactMethod = contactMethod
        self.service = service
        self.view = view
    }

    func viewIsReady() {
       view.setTitle(to: contactMethod.rawValue)
        fetchContacts()
    }

    private func fetchContacts() {
        service.loadContacts { result in
            let contacts = (try? result.get()) ?? []
            self.view.display(contacts.map(\.name))
        }
    }
}
