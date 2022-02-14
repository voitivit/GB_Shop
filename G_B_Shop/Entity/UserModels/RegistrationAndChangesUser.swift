//
//  RegistrationAndChangesUser.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import Foundation
struct RegistrationAndChangesUser: Codable {
    var userId: Int
    var userLogin: String
    var userPassword: String
    var userName: String
    var userLastname: String
    var userEmail: String
    var userCreditCard: String
    var userBio: String
}
