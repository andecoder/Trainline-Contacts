//
//  DeliveryMethodDetailsTableViewController.swift
//  Mailer
//
//  Copyright © 2017 Trainline. All rights reserved.
//

import UIKit

final class DetailsTableViewController: UITableViewController {

    private let cellIdentifier = "DetailsTableViewCell"

    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
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
        //TOOD: Implement me
        cell.textLabel?.text = "John Appleseed"
        return cell
    }
}
