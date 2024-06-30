//
//  ContactViewModelAdapter.swift
//  Mailer
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import Foundation

enum ContactViewModelAdapter {
    static func adapt(
        load: @escaping (@escaping ([Contact]) -> Void) -> Void,
        contactMethodMapper: @escaping (String) -> ContactMethod
    ) -> (@escaping ([ContactViewModel]) -> Void) -> Void {
        { completion in
            load { contacts in
                let viewModels = contacts.map { viewModel(from: $0, with: contactMethodMapper) }
                completion(viewModels)
            }
        }
    }

    private static func viewModel(from contact: Contact, with mapper: (String) -> ContactMethod) -> ContactViewModel {
        let contactMethod = mapper(contact.address)
        return ContactViewModel(name: contact.fullName, contactMethod: contactMethod)
    }
}
