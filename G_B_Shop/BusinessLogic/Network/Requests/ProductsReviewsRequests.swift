//
//  ProductsReviewsRequests.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 27.01.2022.
//

import Foundation
import Alamofire


class ProductsReviewsRequests: AbstractRequestFactory {
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

extension ProductsReviewsRequests:  ProductsReviewsRequestFactory {
    func productReviewsList(productId: Int, completionHandler: @escaping (AFDataResponse<ProductReviewsList>) -> Void) {
        let requestModel = ProductReviewsListRequest(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func productReviewAdd(productId: Int, userName: String, productRating: Int, userReview: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = ProductReviewAddRequest(baseUrl: baseUrl, productId: productId, userName: userName, productRating: productRating, userReview: userReview)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func productReviewCancel(productId: Int, userName: String, reviewId: Int, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = ProductReviewCancelRequest(baseUrl: baseUrl, productId: productId, userName: userName, reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProductsReviewsRequests {
    struct ProductReviewsListRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "productReviewsList"
        
        let productId: Int
        
        var parameters: Parameters? {
            return [
                "productId": productId
            ]
        }
    }
}

extension ProductsReviewsRequests {
    struct ProductReviewAddRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "productReviewAdd"
        
        let productId: Int
        let userName: String
        let productRating: Int
        let userReview: String
        
        var parameters: Parameters? {
            return [
                "productId": productId,
                "userName": userName,
                "productRating": productRating,
                "userReview": userReview
            ]
        }
    }
}

extension ProductsReviewsRequests {
    struct ProductReviewCancelRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "productReviewCancel"
        
        let productId: Int
        let userName: String
        let reviewId: Int
        
        var parameters: Parameters? {
            return [
                "productId": productId,
                "userName": userName,
                "reviewId": reviewId
            ]
        }
    }
}
