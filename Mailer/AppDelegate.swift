//
//  AppDelegate.swift
//  Mailer
//
//  Copyright © 2017 Trainline. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var repository: ContactRepository = FilePathContactRepository(
        csvReader: CSVReader(),
        filePath: Bundle.main.path(forResource: "Contacts", ofType: "csv")!,
        mapper: ContactMethodMapper.map
    )

    private lazy var navigationController: UINavigationController = {
        let viewController = ContactsUIComposer.listComposedWith(repository: repository, selection: showContacts)
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        configureWindow()

        return true
    }

    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func showContacts(for contactMethod: ContactMethod) {
        let details = DetailsUIComposer.contactListComposedWith(contactMethod: contactMethod, repository: repository)
        navigationController.pushViewController(details, animated: true)
    }
}
