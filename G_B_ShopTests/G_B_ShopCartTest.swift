//
//  G_B_ShopCartTest.swift
//  G_B_ShopTests
//
//  Created by emil kurbanov on 27.01.2022.
//

import XCTest
@testable import G_B_Shop
import Alamofire

class GBShopCartTests: XCTestCase {

    let expectation = XCTestExpectation(description: "Download API data")
    var errorParser: ErrorParserStub!
    
    struct DefaultResultStub: Codable {
        let result: Int
        let userMessage: String?
        let errorMessage: String?
    }
    
    struct CartOrderedProductsListStub: Codable {
        let count: Int
        let productsInCartList: [ProductInCartStub]
    }

    struct ProductInCartStub: Codable {
        let productQuantity: Int
        let productName: String
        let productId: Int
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
    
    func testAddProductToCartRequest() {
        let errorParser = ErrorParserStub()
        let productId = 1
        let productQuantity = 5
        var parameters: Parameters? {
            return [
                "productId": productId,
                "productQuantity": productQuantity
            ]
        }
        
        AF.request("https://intense-retreat-87800.herokuapp.com/productAddToCart", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) { (response: DataResponse<DefaultResultStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDeleteProductFromCartRequest() {
        let errorParser = ErrorParserStub()
        let productId = 1
        let productQuantity = 1
        var parameters: Parameters? {
            return [
                "productId": productId,
                "productQuantity": productQuantity
            ]
        }
        
        AF.request("https://intense-retreat-87800.herokuapp.com/productDeleteFromCart", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) { (response: DataResponse<DefaultResultStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetOrderedProductsListRequest() {
        let errorParser = ErrorParserStub()
        let userId = 123
        var parameters: Parameters? {
            return [
                "userId": userId
            ]
        }
        
        AF.request("https://intense-retreat-87800.herokuapp.com/getProductsInCartList", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) { (response: DataResponse<CartOrderedProductsListStub, AFError>) in
            switch response.result {
            case .success(_):
                break
            case .failure: XCTFail()
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testPayProductsInCartRequest() {
        let errorParser = ErrorParserStub()
        let userId = 1
        let userCreditCard = 427638000000000000
        var parameters: Parameters? {
            return [
                "userId": userId,
                "userCreditCard": userCreditCard
            ]
        }
        
        AF.request("https://intense-retreat-87800.herokuapp.com/payProductsInCart", method: .post, parameters: parameters).responseCodable(errorParser: errorParser) { (response: DataResponse<DefaultResultStub, AFError>) in
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

