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
    private let filePath: String

    init(csvReader: CSVReading, filePath: String) {
        self.csvReader = csvReader
        self.filePath = filePath
    }

    func loadContacts() {
        csvReader.open(path: filePath)
    }
}
    }
}
