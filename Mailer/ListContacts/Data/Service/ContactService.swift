//
//  ContactService.swift
//  Mailer
//
//  Created by Anderson Costa on 03/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

final class ContactService {

    private let csvReader: CSVReading

    init(csvReader: CSVReading) {
        self.csvReader = csvReader
    }

    func loadContacts() {
        csvReader.open(path: "")
    }
}
