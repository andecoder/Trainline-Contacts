//
//  CSVReader.swift
//  CSVReader
//
//  Created by Matthew Hasler on 24/11/2018.
//  Copyright © 2018 Matthew Hasler. All rights reserved.
//

import Foundation

@objcMembers class CSVReader: NSObject, CSVReading {

    private let separator: String
    var inputStream: InputStream?

    init(separator: String = "\t") {
        self.separator = separator
    }
    
    func open(path: String) {
        inputStream = InputStream(fileAtPath: path)
        inputStream?.open()
    }
    
    func close() {
        inputStream?.close()
    }
    
    func readNextRow() -> [Substring]? {
        let bufferSize = 8
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        var resultString = ""
        
        while (inputStream?.read(buffer, maxLength: 1) ?? 0) > 0 {
            let char = String(cString: buffer)
            if char == "\n" {
                break;
            }
            resultString += char
        }
        
        if resultString.isEmpty {
            return nil
        } else {
            let separatorChar = Character(separator)
            return resultString.split(separator: separatorChar)
        }
    }
}
