//
//  CartOrderedProductsList.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 27.01.2022.
//

import Foundation
struct CartOrderedProductsList: Codable {
    let count: Int
    let productsInCartList: [CartProduct]
}
