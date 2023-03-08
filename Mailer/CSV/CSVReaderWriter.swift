//
//  CSVReaderWriter.swift
//  CSVReader
//
//  Created by Matthew Hasler on 24/11/2018.
//  Copyright © 2018 Matthew Hasler. All rights reserved.
//

import Foundation

@objc enum FileMode: Int {
    @objc(FileModeRead) case read = 0
    @objc(FileModeWrite) case write
}

/// CSVReaderWriter is a subclass of NSObject for Objective-C backwards compatibility.
@objcMembers class CSVReaderWriter: NSObject {
    
    private let reader: CSVReading
    private let writer: CSVWriting
    private let separator: String
    
    /// Constructor for backwards compatibility.
    /// It creates a default CSVReader, a default CSVWriter and set the sparator to "\t" by default.
    override init() {
        self.reader = CSVReader()
        self.writer = CSVWriter()
        self.separator = "\t"
        super.init()
    }
    
    /// A new constructor allows dependency injection and supporting custom separator.
    init(reader: CSVReading = CSVReader(), writer: CSVWriting = CSVWriter(), separator: String = "\t") {
        self.reader = reader
        self.writer = writer
        self.separator = separator
        super.init()
    }
    
    deinit {
        self.close()
    }
    
    @objc(open:mode:)
    func open(path: String, mode: FileMode) {
        switch mode {
        case .read:
            reader.open(path: path)
        case .write:
            writer.open(path: path)
        }
    }

    /// Method for backwards compatibility
    /// This method translates between String and NSString and calling the new method
    /// as inout for String cannot interop to Objective-C
    @objc(read:column2:)
    func read(column1: UnsafeMutablePointer<NSString?>?, column2: UnsafeMutablePointer<NSString?>?) -> Bool {
        var string1, string2: String?
        let result = read(column1: &string1, column2: &string2)
        column1?.pointee = string1 == nil ? nil : NSString(string: string1!)
        column2?.pointee = string2 == nil ? nil : NSString(string: string2!)
        return result
    }

    func read(column1: inout String?, column2: inout String?) -> Bool {
        guard let resultcolumns = reader.readNextRow(),
            resultcolumns.count >= 2 else {
            column1 = nil
            column2 = nil
            return false
        }
        
        column1 = String(resultcolumns[0])
        column2 = String(resultcolumns[1])
        return true
    }
    
    /// Method for backwards compatibility.
    /// This method translates between [String] and NSMutableArray and calling the new method
    /// as inout for [String] cannot interop to Objective-C
    @objc(read:)
    func read(columns: NSMutableArray?) -> Bool {
        var stringArray = [String]()
        let result = read(columns: &stringArray)
    
        let nsStringArray = stringArray.map{ $0 as NSString }
        columns?.removeAllObjects()
        columns?.addObjects(from: nsStringArray)
        return result
    }
    
    /// I made an assumption here that the method should read all columns
    /// in the string array instead of 2
    func read(columns: inout [String]) -> Bool {
        guard let resultcolumns = reader.readNextRow(),
            resultcolumns.count != 0 else {
                columns.removeAll()
                return false
        }
        
        columns = resultcolumns.map {
            String($0)
        }
        return true
    }
    
    @objc(write:)
    func write(columns: [String]) {
        writer.write(columns: columns, separator: separator)
    }
    
    func close() {
        reader.close()
        writer.close()
    }
}
