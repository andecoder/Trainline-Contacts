//
//  ContactTableViewCell.swift
//  Mailer
//
//  Copyright © 2020 Trainline. All rights reserved.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func display(_ viewModel: ContactCellViewModel) {
        textLabel?.text = viewModel.name
        detailTextLabel?.text = viewModel.contactMethod
    }
}
