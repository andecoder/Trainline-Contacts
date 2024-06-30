//
//  ContactLoader.swift
//  Mailer
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import Foundation

struct ContactLoader {

    private let filePath: String
    private let reader: CSVReading

    init(filePath: String, reader: CSVReading) {
        self.filePath = filePath
        self.reader = reader
    }

    func load(completion: @escaping ([Contact]) -> Void) {
        reader.open(path: filePath)
        var contacts: [Contact] = []
        while let row = reader.readNextRow() {
            guard row.count == 4 else { continue }
            let contact = Contact(
                fullName: String(row[0]),
                address: String(row[1]),
                phoneNumber: String(row[2]),
                email: String(row[3])
            )
            contacts.append(contact)
        }
        reader.close()
        completion(contacts)
    }
}
