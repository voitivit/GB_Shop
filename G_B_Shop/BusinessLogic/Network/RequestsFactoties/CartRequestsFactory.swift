//
//  CartRequestsFactory.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 27.01.2022.
//

import Foundation
import Alamofire

protocol CartRequestsFactory {
    func addProductToCart(productId: Int, productQuantity: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
    func deleteProductToCart(productId: Int, productQuantity: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
    func getCartProductsList(userId: Int, completionHandler: @escaping (AFDataResponse<CartOrderedProductsList>) -> Void)
    func payCartProducts(userId: Int, userCreditCard: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
}
