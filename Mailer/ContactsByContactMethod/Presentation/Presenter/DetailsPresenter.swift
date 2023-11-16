//
//  DetailsPresenter.swift
//  Mailer
//
//  Created by Anderson Costa on 15/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

struct DetailsPresenter {

    private let contactMethod: ContactMethod
    private let view: DetailsView

    init(contactMethod: ContactMethod, view: DetailsView) {
        self.contactMethod = contactMethod
        self.view = view
    }

    func viewIsReady() {
        if contactMethod == .post {
            view.setTitle(to: "Post")
        } else {
            view.setTitle(to: "SMS")
        }
    }
}
