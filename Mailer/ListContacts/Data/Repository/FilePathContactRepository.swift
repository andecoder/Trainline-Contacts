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
        var contacts: Set<Contact> = []
        while let row = csvReader.readNextRow() {
            let contact = Contact(
                name: String(row[0]),
                contactMethod: mapper(String(row[1]))
            )
            contacts.insert(contact)
        }
        csvReader.close()
        return contacts
    }()
}

extension Contact: Hashable {
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name == rhs.name && lhs.contactMethod == rhs.contactMethod
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(contactMethod)
    }
}
