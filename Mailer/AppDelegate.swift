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
        
        let fakeUseCase = LoadContactsFakeUseCase()
        let viewController = ContactsTableViewController(useCase: fakeUseCase)

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        
        // TODO: Remove me
        let path = Bundle.main.path(forResource: "Contacts", ofType: "csv")!
        let reader = CSVReader()
        reader.open(path: path)
        while let row = reader.readNextRow() {
            print(row)
        }

        return true
    }

    private final class LoadContactsFakeUseCase: LoadContactsUseCase {

        func loadContacts() { }
    }
}
