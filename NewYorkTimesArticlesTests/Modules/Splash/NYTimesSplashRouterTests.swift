//
//  NYTimesSplashRouterTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesSplashRouterTests: XCTestCase {
    var sut: NYTimesSplashRouter!
    
    override func setUpWithError() throws {
        sut = NYTimesSplashRouter()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testStart() {
        XCTAssertNotNil(sut.start())
    }
    
    func testSetNavigation() {
        XCTAssertNil(sut.navigation)
        sut.setNavigation(UINavigationController())
        XCTAssertNotNil(sut.navigation)
    }
    
    func testNavigateToHome() {sut.setNavigation(UINavigationController())
        sut.navigateToHome(articles: [])
        let expect = expectation(description: "Expect wait")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
        XCTAssertTrue(sut.navigation?.topViewController is NYTimesHomeViewController)
    }
    
    func testGoToLoginWithNoNav() {
        sut.navigateToHome(articles: [])
        XCTAssertFalse(sut.navigation?.topViewController is NYTimesHomeViewController)
    }
}
