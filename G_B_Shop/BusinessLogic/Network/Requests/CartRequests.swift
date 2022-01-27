//
//  CartRequests.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 27.01.2022.
//

import Foundation
import Alamofire

class CartRequests: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://intense-retreat-87800.herokuapp.com/")!
    
    init (errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension CartRequests:  CartRequestsFactory {
    func addProductToCart(productId: Int, productQuantity: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = AddProductToCartRequest(baseUrl: baseUrl, productId: productId, productQuantity: productQuantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteProductToCart(productId: Int, productQuantity: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = DeleteProductFromCart(baseUrl: baseUrl, productId: productId, productQuantity: productQuantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getCartProductsList(userId: Int, completionHandler: @escaping (AFDataResponse<CartOrderedProductsList>) -> Void) {
        let requestModel = GetCartProductsList(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payCartProducts(userId: Int, userCreditCard: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = PayCartProducts(baseUrl: baseUrl, userId: userId, userCreditCard: userCreditCard)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension CartRequests {
    struct AddProductToCartRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "productAddToCart"
        
        let productId: Int
        let productQuantity: Int
        
        var parameters: Parameters? {
            return [
                "productId": productId,
                "productQuantity": productQuantity
            ]
        }
    }
}

extension CartRequests {
    struct DeleteProductFromCart: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "productDeleteFromCart"
        
        let productId: Int
        let productQuantity: Int
        
        var parameters: Parameters? {
            return [
                "productId": productId,
                "productQuantity": productQuantity
            ]
        }
    }
}

extension CartRequests {
    struct GetCartProductsList: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getProductsInCartList"
        
        let userId: Int
        
        var parameters: Parameters? {
            return [
                "userId": userId
            ]
        }
    }
}

extension CartRequests {
    struct PayCartProducts: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payProductsInCart"
        
        let userId: Int
        let userCreditCard: Int
        
        var parameters: Parameters? {
            return [
                "userId": userId,
                "userCreditCard": userCreditCard
            ]
        }
    }
}
