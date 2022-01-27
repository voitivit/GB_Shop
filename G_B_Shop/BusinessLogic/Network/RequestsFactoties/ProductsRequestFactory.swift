//
//  ProductsRequestFactory.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
import Alamofire
protocol ProductsRequestFactory {
    func productList(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<ProductList>) -> Void)
    func product(productId: Int, completionHandler: @escaping (AFDataResponse<Product>) -> Void)
}
