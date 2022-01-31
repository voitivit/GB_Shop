//
//  Logger.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import Foundation

struct Logger: ExpressibleByStringLiteral {
    
    let message: String
    
    init(stringLiteral value: String) {
        self.message = value
    }
}

func logging(_ logInstance: Any, file: String = #file, funcName: String = #function, line: Int = #line) {
    let logMessage = "\(file) \(funcName) \(line): \(logInstance)"
    print("\(Date()): \(logMessage)")
}

func logging(_ logInstance: Logger, file: String = #file, funcName: String = #function, line: Int = #line) {
    logging(logInstance.message, funcName: funcName, line: line)
}

extension Logger {
    
    static var funcStart: Logger { "-->" }
    static var funcEnd: Logger { "<--" }
    static var call: Logger { "--" }
}
