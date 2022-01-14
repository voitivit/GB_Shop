//
//  AuthRequestFactory.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
import Alamofire
protocol AuthRequestFactory {
    func login(userLogin: String, userPassword: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(userLogin: String, userPassword: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void)
}
