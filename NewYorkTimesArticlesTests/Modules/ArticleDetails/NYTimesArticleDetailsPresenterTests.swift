//
//  NYTimesArticleDetailsPresenterTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesArticleDetailsPresenterTests: XCTestCase {
    var sut: NYTimesArticleDetailsPresenter!
    var interactor: NYTimesArticleDetailsInteractorMock!
    var router: NYTimesArticleDetailsRouterMock!
    var view: NYTimesArticleDetailsViewControllerMock!
    var article: NYTimesArticle!
    
    override func setUpWithError() throws {
        interactor = NYTimesArticleDetailsInteractorMock()
        router = NYTimesArticleDetailsRouterMock()
        view = NYTimesArticleDetailsViewControllerMock()
        article = NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: [NYTimesMediaData(type: .image, copyright: nil, images: [NYTimesMediaImage(url: "url", format: .large)])])
        sut = NYTimesArticleDetailsPresenter(interactor: interactor, router: router, article: article)
        sut.setView(view)
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        router = nil
        view = nil
        sut = nil
        article = nil
    }
    
    func testRequestArticleImage() {
        let expect = expectation(description: "Test request article image")
        interactor.expectGetArticleImage = expect
        sut.requestArticleImage()
        
        wait(for: [expect], timeout: 1)
    }
    
    func testRequestArticleImageInvalidURL() {
        let auxArticle = NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)
        let auxSut = NYTimesArticleDetailsPresenter(interactor: interactor, router: router, article: auxArticle)
        XCTAssertNotNil(auxSut.requestArticleImage())
    }
    
    func testResponseArticleImage() {
        let expect = expectation(description: "Test response article image")
        view.expectNotifyArticleImage = expect
        sut.responseArticleImage(image: UIImage())
        wait(for: [expect], timeout: 1)
    }
    
    func testResponseArticleInvalidImage() {
        XCTAssertNotNil(sut.responseArticleImage(image: nil))
    }
    
    func testRequestArticleData() {
        XCTAssertEqual(sut.requestArticleData().id, article.id)
    }
}
