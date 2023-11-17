//
//  ContactLoaderServiceMock.swift
//  MailerTests
//
//  Created by Anderson Costa on 17/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

@testable import Mailer

final class ContactLoaderServiceMock: ContactLoaderService {

    var loadContactsReturn: Result<[Contact], Error> = .success(Contact.dummyData)

    private(set) var loadContactsCount = 0

    func loadContacts(completion: @escaping (Result<[Contact], Error>) -> Void) {
        loadContactsCount += 1
        completion(loadContactsReturn)
    }
}
