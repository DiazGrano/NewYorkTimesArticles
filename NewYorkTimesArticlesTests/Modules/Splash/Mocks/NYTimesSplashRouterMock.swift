//
//  NYTimesSplashRouterMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesSplashRouterMock: NYTimesSplashRouterProtocol {
    var expectNavigateToHome: XCTestExpectation?
    
    func navigateToHome(articles: [NewYorkTimesArticles.NYTimesArticle]) {
        expectNavigateToHome?.fulfill()
    }
}
