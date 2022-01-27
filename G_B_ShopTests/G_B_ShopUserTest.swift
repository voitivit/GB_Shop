//
//  G_B_ShopUserTest.swift
//  G_B_ShopTests
//
//  Created by emil kurbanov on 27.01.2022.
//


import XCTest
@testable import G_B_Shop
import Alamofire

class GBShopUserTests: XCTestCase {

    let expectation = XCTestExpectation(description: "Download API data")
    var errorParser: ErrorParserStub!
    
    struct LoginResultStub: Codable {
        let result: Int
        let user: User
    }
    
    struct DefaultResultStub: Codable {
        let result: Int
        let userMessage: String?
        let errorMessage: String?
    }

    enum ApiErrorStub: Error {
        case fatalError
    }

    struct ErrorParserStub: AbstractErrorParser {
        func parse(_ result: Error) -> Error {
            return ApiErrorStub.fatalError
        }
        
        func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
            return error
        }
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        errorParser = ErrorParserStub()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        errorParser = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
       // self.measure {
            // Put the code you want to measure the time of here.
       // }
    }
    
    func testLoginRequest() {
        let errorParser = ErrorParserStub()
        let userLogin = "User"
        let userPassword = "1234"
        var parameters: Parameters? {
            return [
                "userLogin": userLogin,
                "userPassword": userPassword
            ]
        }
        
        AF.request("https://intense-retreat-87800.herokuapp.com/login", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) { (response: DataResponse<LoginResultStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLogoutRequest() {
        let errorParser = ErrorParserStub()
        let userLogin = "User"
        let userPassword = "1234"
        var parameters: Parameters? {
            return [
                "userLogin": userLogin,
                "userPassword": userPassword
            ]
        }
        
        AF.request("https://intense-retreat-87800.herokuapp.com/logout", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) { (response: DataResponse<DefaultResultStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRegistrationRequest() {
        let errorParser = ErrorParserStub()
        let userId = 1
        let userLogin = "User"
        let userPassword = "1234"
        let userName = "Ivan"
        let userLastname = "Putin"
        let userEmail = "info@kremlin.ru"
        let userCreditCard = "4276380000000000"
        let userBio = "President"
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
        
        AF.request("https://intense-retreat-87800.herokuapp.com/registration", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) { (response: DataResponse<DefaultResultStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDataChangeRequest() {
        let errorParser = ErrorParserStub()
        let userId = 1
        let userLogin = "User"
        let userPassword = "1234"
        let userName = "Ivan"
        let userLastname = "Putin"
        let userEmail = "info@kremlin.ru"
        let userCreditCard = "4276380000000000"
        let userBio = "President"
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
        AF.request("https://intense-retreat-87800.herokuapp.com/changeData", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) { (response: DataResponse<DefaultResultStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

