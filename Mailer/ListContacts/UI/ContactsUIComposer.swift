//
//  ContactsUIComposer.swift
//  Mailer
//
//  Created by Anderson Costa on 13/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import UIKit

enum ContactsUIComposer {

    static func listComposedWith(
        repository: ContactRepository, selection: @escaping (ContactMethod) -> Void
    ) -> UIViewController {
        let viewProxy = WeakRefProxy<ContactsTableViewController>()
        let service = ContactLoaderServiceAdapter(repository: repository)
        let presenter = ContactsTableViewPresenter(service: service, view: viewProxy)
        let viewController = ContactsTableViewController(useCase: presenter) { viewModel in
            guard let contactMethod = ContactMethod(rawValue: viewModel.contactMethod) else { return }
            selection(contactMethod)
        }
        viewProxy.wrap(viewController)
        return viewController
    }
}
