//
//  GetRequestFactory.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 31.01.2022.
//

import Foundation
import Alamofire

protocol GetRequestFactory {
    func getUserData(request: String, completionHandler: @escaping (AFDataResponse<RegistrationAndChangesUser>) -> Void)
}
