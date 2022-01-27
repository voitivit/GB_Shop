//
//  Auth.swift
//  G_B_Shop
//
//  Created by emil kurbanov on 14.01.2022.
//

import Foundation
import Alamofire
class Auth: AbstractRequestFactory {
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

extension Auth: AuthRequestFactory {
    func login(userLogin: String, userPassword: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userLogin, password: userPassword)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userLogin: String, userPassword: String, completionHandler: @escaping (AFDataResponse<DefaultResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, login: userLogin, password: userPassword)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "login"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "userLogin": login,
                "userPassword": password
            ]
        }
    }
}

extension Auth {
    struct Logout: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "logout"
        
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "userLogin": login,
                "userPassword": password
            ]
        }
    }
}
