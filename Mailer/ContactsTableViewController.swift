//
//  ContactsTableViewController.swift
//  Mailer
//
//  Copyright © 2017 Trainline. All rights reserved.
//

import UIKit

final class ContactsTableViewController: UITableViewController {

    private let cellIdentifier = "ContactsTableViewCell"

    private let loadContacts: () -> Void

    init(loadContacts: @escaping () -> Void) {
        self.loadContacts = loadContacts
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Contacts"
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        loadContacts()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Implement me
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        cell.textLabel?.text = "John Appleseed"
        cell.detailTextLabel?.text = "Post"
        //TODO: Implement me
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailsTableViewController(), animated: true)
        //TODO: Implement me
    }
}
