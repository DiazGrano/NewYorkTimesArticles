//
//  NYTimesHomeRouterTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesHomeRouterTests: XCTestCase {
    var sut: NYTimesHomeRouter!
    var navigation: UINavigationController!
    var articles: [NYTimesArticle]!
    
    override func setUpWithError() throws {
        navigation = UINavigationController()
        articles = [NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)]
        sut = NYTimesHomeRouter(navigation: navigation)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        navigation = nil
        articles = nil
    }
    
    func testStart() {
        sut.start(articles: articles)
        let expect = expectation(description: "Expect wait")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
        XCTAssertTrue(sut.navigation.topViewController is NYTimesHomeViewController)
    }
    
    func testNavigateToArticleDetails() {
        XCTAssertNotNil(sut.navigateToArticleDetails(article: articles[0]))
    }
}
