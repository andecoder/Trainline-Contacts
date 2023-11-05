//
//  WeakRefProxy.swift
//  Mailer
//
//  Created by Anderson Costa on 02/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import Foundation

final class WeakRefProxy<T: AnyObject> {
    private weak var obj: T?

    func wrap(_ obj: T) {
        self.obj = obj
    }
}

extension WeakRefProxy: ContactListView where T: ContactListView {

    func display(_ models: [ContactCellViewModel]) {
        obj?.display(models)
    }
}
