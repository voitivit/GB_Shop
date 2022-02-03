//
//  RegistrationAndChanges.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
import Alamofire


class RegistrationAndChanges: AbstractRequestFactory {
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

extension RegistrationAndChanges:  RegistrationAndDataChangesFactory {
    func registration(userId: Int, userLogin: String, userPassword: String, userName: String, userLastname: String, userEmail: String, userCreditCard: String, userBio: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = Registration(baseUrl: baseUrl, userId: userId, userLogin: userLogin, userPassword: userPassword, userName: userName, userLastname: userLastname, userEmail: userEmail, userCreditCard: userCreditCard, userBio: userBio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func dataChange(userId: Int, userLogin: String, userPassword: String, userName: String, userLastname: String, userEmail: String, userCreditCard: String, userBio: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = Changes(baseUrl: baseUrl, userId: userId, userLogin: userLogin, userPassword: userPassword, userName: userName, userLastname: userLastname, userEmail: userEmail, userCreditCard: userCreditCard, userBio: userBio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension RegistrationAndChanges {
    struct Registration: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "registration"
        
        let userId: Int
        let userLogin: String
        let userPassword: String
        let userName: String
        let userLastname: String
        let userEmail: String
        let userCreditCard: String
        let userBio: String
        
        var parameters: Parameters? {
            return [
                "userId": userId,
                "userLogin": userLogin,
                "userPassword": userPassword,
                "userName": userName,
                "userLastname": userLastname,
                "userEmail": userEmail,
                "userCreditCard": userCreditCard,
                "userBio": userBio
            ]
        }
    }
}

extension RegistrationAndChanges {
    struct Changes: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "changeData"
        
        let userId: Int
        let userLogin: String
        let userPassword: String
        let userName: String
        let userLastname: String
        let userEmail: String
        let userCreditCard: String
        let userBio: String
        
        var parameters: Parameters? {
            return [
                "userId": userId,
                "userLogin": userLogin,
                "userPassword": userPassword,
                "userName": userName,
                "userLastname": userLastname,
                "userEmail": userEmail,
                "userCreditCard": userCreditCard,
                "userBio": userBio
            ]
        }
    }
}

