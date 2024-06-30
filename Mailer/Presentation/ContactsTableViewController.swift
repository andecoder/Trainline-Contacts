//
//  ContactsTableViewController.swift
//  Mailer
//
//  Copyright © 2017 Trainline. All rights reserved.
//

import UIKit

final class ContactsTableViewController: UITableViewController {

    typealias DisplayDetails = (ContactViewModel) -> Void
    typealias LoadContacts = (@escaping LoadContactsCallback) -> Void
    typealias LoadContactsCallback = ([ContactViewModel]) -> Void

    private let cellIdentifier = "ContactsTableViewCell"
    private let displayDetails: DisplayDetails
    private let loadContacts: LoadContacts

    private var contacts: [ContactViewModel] = []

    init(displayDetails: @escaping DisplayDetails, loadContacts: @escaping LoadContacts) {
        self.displayDetails = displayDetails
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
        loadContacts { [weak self] contacts in
            self?.contacts = contacts
            self?.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let contact = contacts[indexPath.row]

        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.contactMethod

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        displayDetails(contact)
    }
}
