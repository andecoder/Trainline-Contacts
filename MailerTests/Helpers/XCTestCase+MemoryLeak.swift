//
//  XCTestCase+MemoryLeak.swift
//  MailerTests
//
//  Created by Anderson Costa on 02/11/2023.
//  Copyright © 2023 Trainline. All rights reserved.
//

import XCTest

extension XCTestCase {

    func checkForMemoryLeak(on object: AnyObject, file: StaticString, line: UInt) {
        addTeardownBlock { [weak object] in
            XCTAssertNil(object, file: file, line: line)
        }
    }
}
