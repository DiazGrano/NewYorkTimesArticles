//
//  NYTimesSplashInteractorTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesSplashInteractorTests: XCTestCase {
    var sut: NYTimesSplashInteractor!
    var networkManager: NYTimesNetworkManagerMock!
    var presenter: NYTimesSplashPresenterMock!
    var coreDataHelper: NYTimesCoreDataHelperMock!
    
    override func setUpWithError() throws {
        sut = NYTimesSplashInteractor()
        presenter = NYTimesSplashPresenterMock()
        networkManager = NYTimesNetworkManagerMock()
        coreDataHelper = NYTimesCoreDataHelperMock()
        
        sut.setPresenter(presenter)
        sut.networkManager = networkManager
        sut.coreDataHelper = coreDataHelper
    }

    override func tearDownWithError() throws {
        sut = nil
        networkManager = nil
        presenter = nil
        coreDataHelper = nil
    }
    
    func testGetArticles() {
        networkManager.successModel = NYTimesArticlesResponse(results: [])
        let expect = expectation(description: "Test get articles")
        presenter.expectResponseArticles = expect
        sut.getArticles()
        wait(for: [expect], timeout: 1)
    }
    
    func testGetArticlesError() {
        let expect = expectation(description: "Test get articles error")
        presenter.expectResponseError = expect
        networkManager.isSuccess = false
        sut.getArticles()
        wait(for: [expect], timeout: 1)
    }
    
    func testSaveArticlesToLocal() {
        let expectCoreDataHelper = expectation(description: "Test save articles to local core data helper")
        coreDataHelper.expectSaveArticles = expectCoreDataHelper
        
        let expectPresenter = expectation(description: "Test save articles to local presenter")
        presenter.expectResponseArticles = expectPresenter
        
        sut.saveArticlesToLocal(modelResponse: NYTimesArticlesResponse(results: []))
        
        wait(for: [expectCoreDataHelper, expectPresenter], timeout: 1)
    }
    
    
    func testSearchForLocalArticles() {
        let expectCoreDataHelper = expectation(description: "Test search for local articles core data helper")
        coreDataHelper.expectGetArticles = expectCoreDataHelper
        
        let expectPresenter = expectation(description: "Test search for local articles presenter")
        presenter.expectResponseError = expectPresenter
        
        sut.searchForLocalArticles(errorResponse: NYTimesErrorModel())
        
        wait(for: [expectCoreDataHelper, expectPresenter], timeout: 1)
    }
}
