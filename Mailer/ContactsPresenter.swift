// 
// Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

protocol ContactsView: AnyObject {
    func display(contacts: [ContactsCellViewModel])
}

struct ContactsCellViewModel {
    let fullName: String
    let marketingMethod: String
    let onCellSelected: () -> Void
}

final class ContactsPresenter {

    private let csvReader: CSVReading
    private let mapper: ([String]) -> ContactsCellViewModel
    private let path: String
    private weak var view: ContactsView?

    init(csvReader: CSVReading) {
        self.csvReader = csvReader
    }

    func bind(_ view: ContactsView) {
        self.view = view
    }

    func loadContacts() {
        csvReader.open(path: path)

        csvReader.close()
        view?.display(contacts: [])
    }
}
