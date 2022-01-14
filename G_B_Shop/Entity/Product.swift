//
//  Product.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
struct Product: Codable {
    let productPrice: Int
    let productName: String
    let productDescription: String
    
    enum CodingKeys: String, CodingKey {
            case productPrice
            case productName
            case productDescription
        }
}
