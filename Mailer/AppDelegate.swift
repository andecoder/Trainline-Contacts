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
        window = UIWindow()
        window?.rootViewController = makeInitialViewController()
        window?.makeKeyAndVisible()

        return true
    }

    private func makeInitialViewController() -> UIViewController {
        let viewController = makeContactListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }

    private func makeContactListViewController() -> UIViewController {
        let viewProxy = WeakRefProxy<ContactsTableViewController>()
        let mapper = ContactMethodMapper()
        let repository = FilePathContactRepository(
            csvReader: CSVReader(),
            filePath: Bundle.main.path(forResource: "Contacts", ofType: "csv")!,
            mapper: mapper.map(address:)
        )
        let presenter = ContactsTableViewPresenter(service: ContactService(repository: repository), view: viewProxy)
        let viewController = ContactsTableViewController(useCase: presenter)
        viewProxy.wrap(viewController)
        return viewController
    }
}
