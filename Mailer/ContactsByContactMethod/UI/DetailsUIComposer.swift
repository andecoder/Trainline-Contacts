//
//  DetailsUIComposer.swift
//  Mailer
//
//  Created by Anderson Costa on 17/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import UIKit

enum DetailsUIComposer {

    static func contactListComposedWith(
        contactMethod: ContactMethod,
        repository: ContactRepository
    ) -> UIViewController {
        let viewProxy = WeakRefProxy<DetailsTableViewController>()
        let service = ContactMethodContactLoaderServiceDecorator(contactMethod: contactMethod, repository: repository)
        let presenter = DetailsPresenter(contactMethod: contactMethod, service: service, view: viewProxy)
        let viewController = DetailsTableViewController(viewIsReady: presenter.viewIsReady)
        viewProxy.wrap(viewController)
        return viewController
    }
}
