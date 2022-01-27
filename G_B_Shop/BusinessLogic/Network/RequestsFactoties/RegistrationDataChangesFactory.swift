//
//  RegistrationAndDataChangesFactory.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
import Alamofire
protocol RegistrationAndDataChangesFactory {
    func registration(userId: Int, userLogin: String, userPassword: String, userName: String, userLastname: String, userEmail: String, userCreditCard: String, userBio: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
    func dataChange(userId: Int, userLogin: String, userPassword: String, userName: String, userLastname: String, userEmail: String, userCreditCard: String, userBio: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
}




