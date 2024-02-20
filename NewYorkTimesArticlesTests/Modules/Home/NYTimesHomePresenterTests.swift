//
//  NYTimesHomePresenterTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesHomePresenterTests: XCTestCase {
    var sut: NYTimesHomePresenter!
    var interactor: NYTimesHomeInteractorMock!
    var router: NYTimesHomeRouterMock!
    var view: NYTimesHomeViewControllerMock!
    var articles: [NYTimesArticle]!
    
    override func setUpWithError() throws {
        interactor = NYTimesHomeInteractorMock()
        router = NYTimesHomeRouterMock()
        view = NYTimesHomeViewControllerMock()
        articles = [NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)]
        sut = NYTimesHomePresenter(interactor: interactor, router: router, articles: articles)
        sut.setView(view)
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        router = nil
        view = nil
        sut = nil
        articles = nil
    }

    func testRequestArticles() {
        let articles = sut.requestArticles()
        XCTAssertEqual(articles.count, articles.count)
        XCTAssertEqual(articles.first?.id, articles.first?.id)
    }
    
    func testRequestArticleDetails() {
        let expect = expectation(description: "Test request article details")
        router.expectNavigateToArticleDetails = expect
        sut.requestArticleDetails(article: articles[0])
        
        wait(for: [expect], timeout: 1)
    }
}
