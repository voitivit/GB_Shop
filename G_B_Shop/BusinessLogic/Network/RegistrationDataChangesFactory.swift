//
//  RegistrationAndDataChangesFactory.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
import Alamofire
protocol RegistrationAndDataChangesFactory {
    func registration(idUser: Int, userName: String, password: String, userEmail: String, userGender: String, userCreditCardNumber: String, userBio: String, completionHandler: @escaping (AFDataResponse<RegistrationUserResult>) -> Void)
    func dataChange(idUser: Int, userName: String, password: String, userEmail: String, userGender: String, userCreditCardNumber: String, userBio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}

