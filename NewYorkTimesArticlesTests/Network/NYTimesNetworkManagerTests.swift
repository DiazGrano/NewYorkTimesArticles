//
//  NYTimesNetworkManagerTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesNetworkManagerTests: XCTestCase {
    var sut: NYTimesNetworkManager!
    
    override func setUpWithError() throws {
        sut = NYTimesNetworkManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testRequestWithResponse() {
        let expect = expectation(description: "Test request with response")
        sut.request(url: NYTimesURLsHelper.nyTimesWeekMostViewedArticles, method: .get, responseType: NYTimesArticlesResponse.self, appendAPIKey: true) { modelResponse in
            XCTAssertNotNil(modelResponse)
            expect.fulfill()
        } failure: { errorResponse in
        }
        wait(for: [expect], timeout: 5)
    }
    
    func testRequestWithError() {
        let expect = expectation(description: "Test request with error")
        sut.request(url: NYTimesURLsHelper.nyTimesWeekMostViewedArticles, method: .get, responseType: NYTimesArticlesResponse.self, appendAPIKey: false) { modelResponse in
        } failure: { errorResponse in
            XCTAssertNotNil(errorResponse)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
    
    func testRequestWithInvalidURL() {
        let expect = expectation(description: "Test request with invalid url")
        sut.request(url: "twqewqe wqr ", method: .get, responseType: NYTimesArticlesResponse.self, appendAPIKey: false) { modelResponse in
        } failure: { errorResponse in
            XCTAssertNotNil(errorResponse)
            XCTAssertEqual(errorResponse.defaultErrorType, .badURL)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
    
    func testRequestWithInvalid() {
        let expect = expectation(description: "Test request with invalid")
        sut.request(url: "https://www.invalidurlxdxd.xd", method: .get, responseType: NYTimesArticlesResponse.self, appendAPIKey: false) { modelResponse in
        } failure: { errorResponse in
            XCTAssertNotNil(errorResponse)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
}
