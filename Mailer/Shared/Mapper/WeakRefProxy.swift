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

extension WeakRefProxy: DetailsView where T: DetailsView {
   
    func display(_ contacts: [String]) {
        obj?.display(contacts)
    }

    func setTitle(to title: String) {
        obj?.setTitle(to: title)
    }
}
