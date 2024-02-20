//
//  NYTimesSplashViewControllerMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesSplashViewControllerMock: NYTimesSplashViewControllerProtocol {
    var expectNotifyError: XCTestExpectation?
    var expectNotifySuccessArticles: XCTestExpectation?
    
    func notifyError(data: NewYorkTimesArticles.NYTimesErrorModel, localArticlesExists: Bool) {
        expectNotifyError?.fulfill()
    }
    
    func notifySuccessArticles() {
        expectNotifySuccessArticles?.fulfill()
    }
}
