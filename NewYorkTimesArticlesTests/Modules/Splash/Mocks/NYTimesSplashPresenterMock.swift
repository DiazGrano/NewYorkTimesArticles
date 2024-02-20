//
//  NYTimesSplashPresenterMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesSplashPresenterMock: NYTimesSplashPresenterProtocol {
    var expectRequestArticles: XCTestExpectation?
    var expectResponseArticles: XCTestExpectation?
    var expectResponseError: XCTestExpectation?
    var expectRequestHomeWithLocalArticles: XCTestExpectation?
    
    func requestArticles() {
        expectRequestArticles?.fulfill()
    }
    
    func responseArticles(data: NewYorkTimesArticles.NYTimesArticlesResponse) {
        expectResponseArticles?.fulfill()
    }
    
    func responseError(data: NewYorkTimesArticles.NYTimesErrorModel, localArticles: NewYorkTimesArticles.NYTimesArticlesResponse?) {
        expectResponseError?.fulfill()
    }
    
    func requestHomeWithLocalArticles() {
        expectRequestHomeWithLocalArticles?.fulfill()
    }
}
