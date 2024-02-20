//
//  NYTimesHomePresenterMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesHomePresenterMock: NYTimesHomePresenterProtocol {
    var expectRequestArticles: XCTestExpectation?
    var expectRequestArticleDetails: XCTestExpectation?
    var articles: [NewYorkTimesArticles.NYTimesArticle] = []
    
    func requestArticles() -> [NewYorkTimesArticles.NYTimesArticle] {
        expectRequestArticles?.fulfill()
        return articles
    }
    
    func requestArticleDetails(article: NewYorkTimesArticles.NYTimesArticle) {
        expectRequestArticleDetails?.fulfill()
    }
}
