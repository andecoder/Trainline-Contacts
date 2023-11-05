//
//  ContactsTableViewController.swift
//  Mailer
//
//  Copyright © 2017 Trainline. All rights reserved.
//

import UIKit

final class ContactsTableViewController: UITableViewController, ContactListView {
    
    private let cellIdentifier = "ContactsTableViewCell"

    private let useCase: LoadContactsUseCase
    private let didSelect: () -> Void

    private var contacts: [ContactCellViewModel] = []

    init(useCase: LoadContactsUseCase, didSelect: @escaping () -> Void) {
        self.didSelect = didSelect
        self.useCase = useCase
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
        useCase.loadContacts()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if contacts.count > indexPath.row, let cell = cell as? ContactTableViewCell {
            let contact = contacts[indexPath.row]
            cell.display(contact)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect()
    }

    func display(_ contacts: [ContactCellViewModel]) {
        self.contacts = contacts
        tableView.reloadData()
    }
}
