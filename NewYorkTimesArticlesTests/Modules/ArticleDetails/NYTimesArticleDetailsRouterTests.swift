//
//  NYTimesArticleDetailsRouterTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesArticleDetailsRouterTests: XCTestCase {
    var sut: NYTimesArticleDetailsRouter!
    var navigation: UINavigationController!
    var article: NYTimesArticle!
    
    override func setUpWithError() throws {
        navigation = UINavigationController()
        article = NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)
        sut = NYTimesArticleDetailsRouter(navigation: navigation)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        navigation = nil
        article = nil
    }
    
    func testStart() {
        sut.start(article: article)
    }
}
