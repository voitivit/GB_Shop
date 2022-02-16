//
//  CartSingletone.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.02.2022.
//

import Foundation
class CartSingletone {
    var cartList: [Product] = []
    
    static let shared = CartSingletone()
    private init(){}
}
