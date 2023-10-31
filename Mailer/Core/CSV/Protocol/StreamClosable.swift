//
//  StreamClosable.swift
//  CSVReaderWriter
//
//  Created by Matthew Hasler on 24/11/2018.
//  Copyright © 2018 Matthew Hasler. All rights reserved.
//

import Foundation

@objc protocol StreamClosable {
    func close()
}
