//
//  ContactsTableViewController.swift
//  Mailer
//
//  Copyright © 2017 Trainline. All rights reserved.
//

import UIKit

final class ContactsTableViewController: UITableViewController {
    
    private let cellIdentifier = "ContactsTableViewCell"

    private var contacts: [ContactCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if contacts.count > indexPath.row {
            let contact = contacts[indexPath.row]
            cell.textLabel?.text = contact.name
            cell.detailTextLabel?.text = contact.contactMethod
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailsTableViewController(), animated: true)
        //TODO: Implement me
    }

    func display(_ contacts: [ContactCellViewModel]) {
        self.contacts = contacts
        tableView.reloadData()
    }
}
