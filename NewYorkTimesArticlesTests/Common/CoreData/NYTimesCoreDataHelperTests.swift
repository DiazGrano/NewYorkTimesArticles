//
//  NYTimesCoreDataHelperTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesCoreDataHelperTests: XCTestCase {
    var sut: NYTimesCoreDataHelper!
    var articlesResponse: NYTimesArticlesResponse!
    
    override func setUpWithError() throws {
        sut = NYTimesCoreDataHelper()
        articlesResponse = NYTimesArticlesResponse(results: [NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)])
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSaveArticles() {
        let expect = expectation(description: "Test save articles")
        sut.saveArticles(model: articlesResponse) { [weak self] in
            self?.sut.getArticles {  [weak self] articles in
                XCTAssertEqual(articles?.results?.first?.id, self?.articlesResponse.results?.first?.id)
                expect.fulfill()
            }
        }
        
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBase64ImageByURL() {
        let expect = expectation(description: "Test get base64 image by URL")
        sut.getBase64ImageByURL(url: "https://static01.nyt.com/images/2024/02/18/opinion/18french/18french-thumbStandard.jpg") { image in
            XCTAssertNotNil(image)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBase64ImageByURLError() {
        let expect = expectation(description: "Test get base64 image by URL error")
        sut.getBase64ImageByURL(url: "") { image in
            XCTAssertNil(image)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 1)
    }
    
    func testSaveBase64ImageByURL() {
        let expect = expectation(description: "Test save base64 image by URL")
        sut.saveBase64ImageByURL(url: "url", image: "image") { [weak self] in
            self?.sut.getBase64ImageByURL(url: "url") { image in
                XCTAssertNotNil(image)
                expect.fulfill()
            }
        }
        wait(for: [expect], timeout: 1)
    }
}
