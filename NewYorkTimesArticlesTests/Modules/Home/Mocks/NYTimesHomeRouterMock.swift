//
//  NYTimesHomeRouterMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesHomeRouterMock: NYTimesHomeRouterProtocol {
    var expectNavigateToArticleDetails: XCTestExpectation?
    
    func navigateToArticleDetails(article: NewYorkTimesArticles.NYTimesArticle) {
        expectNavigateToArticleDetails?.fulfill()
    }
}
