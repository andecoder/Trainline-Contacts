//
//  XCTestCase+MemoryLeaks.swift
//  MailerTests
//
//  Created by Anderson Costa on 30/06/2024.
//  Copyright © 2024 Trainline. All rights reserved.
//

import XCTest

extension XCTestCase {

    func trackMemoryLeaks(on sut: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak sut] in
            XCTAssertNil(sut, file: file, line: line)
        }
    }
}
