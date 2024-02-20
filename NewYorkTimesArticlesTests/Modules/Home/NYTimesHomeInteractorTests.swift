//
//  NYTimesHomeInteractorTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesHomeInteractorTests: XCTestCase {
    var sut: NYTimesHomeInteractor!
    var presenter: NYTimesHomePresenterMock!
    
    override func setUpWithError() throws {
        sut = NYTimesHomeInteractor()
        presenter = NYTimesHomePresenterMock()
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
}
