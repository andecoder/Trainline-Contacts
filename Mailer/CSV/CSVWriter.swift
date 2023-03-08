//
//  CSVWriter.swift
//  CSVReader
//
//  Created by Matthew Hasler on 24/11/2018.
//  Copyright © 2018 Matthew Hasler. All rights reserved.
//

import Foundation

@objcMembers class CSVWriter: NSObject, CSVWriting {
    var outputStream: OutputStream?

    func close() {
        outputStream?.close()
    }
    
    func open(path: String) {
        outputStream = OutputStream(toFileAtPath: path, append: false)
        outputStream?.open()
    }
    
    func write(columns: [String], separator: String) {
        var line = columns.joined(separator: separator)
        line.append("\n")
        
        guard let data = line.data(using: .utf8) else { return }
        _ = data.withUnsafeBytes {
            self.outputStream?.write($0, maxLength: data.count)
        }
    }
}
