//
//  NYTimesImagesHelperTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesImagesHelperTests: XCTestCase {
    var sut: NYTimesImagesHelper!
    var coreDataHelper: NYTimesCoreDataHelperMock!
    
    override func setUpWithError() throws {
        sut = NYTimesImagesHelper.shared
        coreDataHelper = NYTimesCoreDataHelperMock()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testGetImage() {
        let expect = expectation(description: "Test get image")
        sut.getImage(url: "https://static01.nyt.com/images/2024/02/18/opinion/18french/18french-thumbStandard.jpg") { image in
            XCTAssertNotNil(image)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
    }
    
    func testGetImageError() {
        let expect = expectation(description: "Test get image error")
        sut.getImage(url: "") { image in
            XCTAssertNil(image)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
    }
}
