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

    private lazy var navigationController: UINavigationController = {
        let navController = UINavigationController()
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }()

    private lazy var cache: InMemoryContactLoaderCache = {
        let path = Bundle.main.path(forResource: "Contacts", ofType: "csv")!
        let contactLoader = ContactLoader(filePath: path, reader: CSVReader())
        let adaptedLoadContacts = ContactViewModelAdapter.adapt(
            load: contactLoader.load,
            contactMethodMapper: ContactMethodAdapter.method
        )
        let cache = InMemoryContactLoaderCache(loadContacts: adaptedLoadContacts)
        return cache
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = ContactsTableViewController(displayDetails: displayDetailsScreen, loadContacts: cache.load)
        navigationController.setViewControllers([viewController], animated: true)

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    private func displayDetailsScreen(for contactMethod: ContactMethod) {
        let viewController = DetailsTableViewController(title: contactMethod.title) { [weak cache] completion in
            cache?.contacts(with: contactMethod, completion: completion)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
