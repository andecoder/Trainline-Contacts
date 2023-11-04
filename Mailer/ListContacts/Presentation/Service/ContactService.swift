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
    private let repository: ContactRepository

    init(csvReader: CSVReading, filePath: String, repository: ContactRepository) {
        self.csvReader = csvReader
        self.filePath = filePath
        self.repository = repository
    }

    func loadContacts(completion: @escaping ([Contact]) -> Void) {
        csvReader.open(path: filePath)
        var contacts: [Contact] = []
        while let row = csvReader.readNextRow() {
            let contact = Contact(
                name: String(row[0]),
                contactMethod: contactMethod(fromAddress: String(row[1]))
            )
            contacts.append(contact)
        }
        completion(contacts)
        csvReader.close()
    }

    private func contactMethod(fromAddress address: String) -> String {
        let contactMethodToCountryMapping: [String: [String]] = [
            "e-Mail": ["Czech Republic", "Saint Lucia"],
            "Post": ["Italy", "Australia", "Finland"]
        ]
        let contactMethod = contactMethodToCountryMapping.first {
            let country = address.components(separatedBy: "|").last ?? ""
            return $0.value.contains(country)
        }
        return contactMethod?.key ?? "SMS"
    }
}
