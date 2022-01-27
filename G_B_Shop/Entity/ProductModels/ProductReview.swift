//
//  ProductReview.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 27.01.2022.
//

import Foundation
struct ProductReview: Codable {
    let reviewId: Int
    let userName: String
    let productRating: Int
    let userReview: String
}
