//
//  InMemoryContactLoaderCache.swift
//  Mailer
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import Foundation

final class InMemoryContactLoaderCache {

    private let loadContacts: (([ContactViewModel]) -> Void) -> Void
    private var contacts: [ContactViewModel] = []

    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    init(loadContacts: @escaping (([ContactViewModel]) -> Void) -> Void) {
        self.loadContacts = loadContacts
    }

    func load(completion: @escaping ([ContactViewModel]) -> Void) {
        loadContacts(completion: completion)
    }

    func contacts(with method: ContactMethod, completion: @escaping ([String]) -> Void) {
        loadContacts { contacts in
            let names = contacts
                .filter { $0.contactMethod == method }
                .map(\.name)
            completion(names)
        }
    }

    private func loadContacts(completion: @escaping ([ContactViewModel]) -> Void) {
        let operation = BlockOperation { [weak self] in
            guard let self else { return }
            guard contacts.isEmpty else {
                completion(contacts)
                return
            }
            loadContacts { [weak self] contacts in
                self?.contacts = contacts
                completion(contacts)
            }
        }
        queue.addOperation(operation)
    }
}
