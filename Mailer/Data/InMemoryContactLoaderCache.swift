//
//  InMemoryContactLoaderCache.swift
//  Mailer
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import Foundation

final class InMemoryContactLoaderCache {

    private let loadContacts: (@escaping ([ContactViewModel]) -> Void) -> Void
    private var contacts: [ContactViewModel] = []
    private var hasPendingRequest = false
    private var callbackQueue: [([ContactViewModel]) -> Void] = []

    init(loadContacts: @escaping (@escaping ([ContactViewModel]) -> Void) -> Void) {
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
        guard !hasPendingRequest else {
            callbackQueue.append(completion)
            return
        }
        hasPendingRequest = true
        guard contacts.isEmpty else {
            let contacts = contacts
            completion(contacts)
            requestDidComplete()
            return
        }
        loadContacts { [weak self] contacts in
            self?.contacts = contacts
            completion(contacts)
            self?.requestDidComplete()
        }
    }

    private func requestDidComplete() {
        hasPendingRequest = false
        guard !callbackQueue.isEmpty else { return }
        let callback = callbackQueue.removeFirst()
        loadContacts(completion: callback)
    }
}
