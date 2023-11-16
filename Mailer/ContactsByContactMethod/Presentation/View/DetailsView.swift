//
//  DetailsView.swift
//  Mailer
//
//  Created by Anderson Costa on 16/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

protocol DetailsView {
    func display(_: [String])
    func setTitle(to: String)
}
