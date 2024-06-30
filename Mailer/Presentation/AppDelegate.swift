//
//  AppDelegate.swift
//  Mailer
//
//  Copyright © 2017 Trainline. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true

        let path = Bundle.main.path(forResource: "Contacts", ofType: "csv")!
        let contactLoader = ContactLoader(filePath: path, reader: CSVReader())
        let cache = InMemoryContactLoaderCache(loadContacts: ContactViewModelAdapter.adapt(load: contactLoader.load, contactMethodMapper: ContactMethodAdapter.method))
        let viewController = ContactsTableViewController(
            displayDetails: { contactMethod in
                let viewController = DetailsTableViewController(title: contactMethod.title) { completion in
                    cache.contacts(with: contactMethod, completion: completion)
                }
                navigationController.pushViewController(viewController, animated: true) },
            loadContacts: cache.load
        )
        navigationController.setViewControllers([viewController], animated: true)

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
