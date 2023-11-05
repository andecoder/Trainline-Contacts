//
//  FilePathContactRepository.swift
//  Mailer
//
//  Created by Anderson Costa on 04/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

final class FilePathContactRepository: ContactRepository {
    
    private let csvReader: CSVReading
    private let filePath: String
    private let mapper: (String) -> ContactMethod

    init(csvReader: CSVReading, filePath: String, mapper: @escaping (String) -> ContactMethod) {
        self.csvReader = csvReader
        self.filePath = filePath
        self.mapper = mapper
    }

    private(set) lazy var contacts: [Contact] = {
        csvReader.open(path: filePath)
        var contacts: [Contact] = []
        while let row = csvReader.readNextRow() {
            let contact = Contact(
                name: String(row[0]),
                contactMethod: mapper(String(row[1])).rawValue
            )
            contacts.append(contact)
        }
        csvReader.close()
        return contacts
    }()
}
