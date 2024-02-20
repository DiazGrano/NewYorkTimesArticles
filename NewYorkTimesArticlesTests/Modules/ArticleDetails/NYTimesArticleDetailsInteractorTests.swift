//
//  NYTimesArticleDetailsInteractorTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesArticleDetailsInteractorTests: XCTestCase {
    var sut: NYTimesArticleDetailsInteractor!
    var presenter: NYTimesArticleDetailsPresenterMock!
    
    override func setUpWithError() throws {
        sut = NYTimesArticleDetailsInteractor()
        presenter = NYTimesArticleDetailsPresenterMock()
    }

    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
    }
    
    func testSetPresenter() {
        XCTAssertNil(sut.presenter)
        sut.setPresenter(presenter)
        XCTAssertNotNil(sut.presenter)
    }
    
    func testGetArticleImage() {
        sut.setPresenter(presenter)
        let expect = expectation(description: "Test get article image")
        sut.getArticleImage(url: "")
        presenter.expectResponseArticleImage = expect
        wait(for: [expect], timeout: 5)
    }
}
