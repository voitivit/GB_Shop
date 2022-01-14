//
//  G_B_ShopTests.swift
//  G_B_ShopTests
//
//  Created by emil kurbanov on 03.01.2022.
//

import XCTest
@testable import G_B_Shop
import Alamofire

class GBShopDKTests: XCTestCase {

    let expectation = XCTestExpectation(description: "Download API data")
    var errorParser: ErrorParserStub!
    
    struct LoginResultStub: Codable {
        let result: Int
        let user: User
    }
    
    struct LogoutResultStub: Codable {
        let result: Int
    }
    
    struct RegistrationUserResultStub: Codable {
        let result: Int
        let userMessage: String
    }
    
    struct ChangeUserDataResultStub: Codable {
        let result: Int
    }
    
    struct ProductListStub: Codable {
        let id: Int
        let productName: String
        let price: Int
        
        
        enum CodingKeys: String, CodingKey {
            case id = "id_product"
            case productName = "product_name"
            case price
        }
    }

    struct ProductStub: Codable {
        let result: Int
        let productName: String
        let productPrice: Int
        let productDescription: String
        
        enum CodingKeys: String, CodingKey {
            case result
            case productName = "product_name"
            case productPrice = "product_price"
            case productDescription = "product_description"
        }
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

    func testLoginRequest() {
        let errorParser = ErrorParserStub()
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/login.json").responseCodable(errorParser: errorParser) { (response: DataResponse<LoginResultStub, AFError>) in
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
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/logout.json").responseCodable(errorParser: errorParser) { (response: DataResponse<LogoutResultStub, AFError>) in
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
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/registerUser.json").responseCodable(errorParser: errorParser) { (response: DataResponse<RegistrationUserResultStub, AFError>) in
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
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/changeUserData.json").responseCodable(errorParser: errorParser) { (response: DataResponse<ChangeUserDataResultStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testProductRequest() {
        let errorParser = ErrorParserStub()
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/getGoodById.json").responseCodable(errorParser: errorParser) { (response: DataResponse<ProductStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testProductListRequest() {
        let errorParser = ErrorParserStub()
        
        AF.request("https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/catalogData.json").responseCodable(errorParser: errorParser) { (response: DataResponse<[ProductListStub], AFError>) in
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

