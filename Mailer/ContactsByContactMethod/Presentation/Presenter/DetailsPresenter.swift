//
//  DetailsPresenter.swift
//  Mailer
//
//  Created by Anderson Costa on 15/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

struct DetailsPresenter {

    private let view: DetailsView

    init(view: DetailsView) {
        self.view = view
    }

    func viewIsReady() {
        view.setTitle(to: "Post")
    }
}
