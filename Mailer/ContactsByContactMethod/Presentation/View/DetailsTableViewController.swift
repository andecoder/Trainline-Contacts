//
//  DeliveryMethodDetailsTableViewController.swift
//  Mailer
//
//  Copyright © 2017 Trainline. All rights reserved.
//

import UIKit

final class DetailsTableViewController: UITableViewController {

    private let cellIdentifier = "DetailsTableViewCell"
    
    private let contactMethod: ContactMethod
    private var contacts: [String] = []
    private let viewIsReady: () -> Void

    init(contactMethod: ContactMethod, viewIsReady: @escaping () -> Void) {
        self.contactMethod = contactMethod
        self.viewIsReady = viewIsReady
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = contactMethod.rawValue
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        viewIsReady()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row]
        return cell
    }

    func display(_ contacts: [String]) {
        self.contacts = contacts
    }

    func setTitle(to title: String) {
        self.title = title
    }
}
