//
//  AbstractErrorParser.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
