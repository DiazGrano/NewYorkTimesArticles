//
//  NYTimesHomeViewControllerTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesHomeViewControllerTests: XCTestCase {
    var sut: NYTimesHomeViewController!
    var presenter: NYTimesHomePresenterMock!
    var articles: [NYTimesArticle]!
    
    override func setUpWithError() throws {
        presenter = NYTimesHomePresenterMock()
        sut = NYTimesHomeViewController(presenter: presenter)
        articles = [NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil), NYTimesArticle(id: 321, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)]
        presenter.articles = articles
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        sut = nil
        articles = nil
    }
    
    func testInitComponents() {
        sut.initComponents()
        XCTAssertEqual(sut.view.backgroundColor, .nyTimesWhite)
    }
    
    func testArticleCellTapped() {
        let expect = expectation(description: "Test article cell tapped")
        presenter.expectRequestArticleDetails = expect
        sut.articleCellTapped(data: articles[0])
        wait(for: [expect], timeout: 1)
    }
    
    func testViewWillAppear() {
        sut.viewWillAppear(true)
    }
    
    func testTableViewNumberOfRows() {
        
        let numberOfRows = sut.tableView(sut.mostViewedFactsTable, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, articles.count)
    }
    
    func testTableViewCellForRow() {
        let cell = sut.tableView(sut.mostViewedFactsTable, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is NYTimesArticleViewCell)
    }
    
    func testTableViewCellForRowDefault() {
        presenter.articles = []
        let cell = sut.tableView(sut.mostViewedFactsTable, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertFalse(cell is NYTimesArticleViewCell)
    }
}
