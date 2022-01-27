//
//  CartProduct.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 27.01.2022.
//

import Foundation
struct CartProduct: Codable {
    let productQuantity: Int
    let productName: String
    let productId: Int
}
