//
//  NYTimesSplashPresenterTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesSplashPresenterTests: XCTestCase {
    var sut: NYTimesSplashPresenter!
    var interactor: NYTimesSplashInteractorMock!
    var router: NYTimesSplashRouterMock!
    var view: NYTimesSplashViewControllerMock!
    
    override func setUpWithError() throws {
        interactor = NYTimesSplashInteractorMock()
        router = NYTimesSplashRouterMock()
        view = NYTimesSplashViewControllerMock()
        sut = NYTimesSplashPresenter(interactor: interactor, router: router)
        sut.setView(view)
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        router = nil
        view = nil
        sut = nil
    }
    
    func testRequestArticles() {
        let expect = expectation(description: "test request articles")
        interactor.expectGetArticles = expect
        sut.requestArticles()
        
        wait(for: [expect], timeout: 1)
    }
    
    func testResponseArticles() {
        let expect = expectation(description: "test response articles")
        view.expectNotifySuccessArticles = expect
        let article = NYTimesArticle(id: 0, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)
        sut.responseArticles(data: NYTimesArticlesResponse(results: [article]))
        
        wait(for: [expect], timeout: 1)
    }
    
    func testResponseArticlesEmpty() {
        let expect = expectation(description: "test response articles empty")
        view.expectNotifyError = expect
        sut.responseArticles(data: NYTimesArticlesResponse(results: []))
        
        wait(for: [expect], timeout: 1)
    }
    
    func testResponseError() {
        let expect = expectation(description: "test response error")
        view.expectNotifyError = expect
        sut.responseError(data: NYTimesErrorModel.getDefaultError(type: .unknown), localArticles: nil)
        
        wait(for: [expect], timeout: 1)
    }
    
    func testRequestHomeWithLocalArticles() {
        let expect = expectation(description: "test request home with local articles")
        router.expectNavigateToHome = expect
        let article = NYTimesArticle(id: 0, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)
        sut.localArticles = NYTimesArticlesResponse(results: [article])
        sut.requestHomeWithLocalArticles()
        
        wait(for: [expect], timeout: 1)
    }
    
    func testRequestHomeWithLocalArticlesError() {
        let expect = expectation(description: "test request home with local articles error")
        view.expectNotifyError = expect
        sut.localArticles = nil
        sut.requestHomeWithLocalArticles()
        
        wait(for: [expect], timeout: 1)
    }
}
