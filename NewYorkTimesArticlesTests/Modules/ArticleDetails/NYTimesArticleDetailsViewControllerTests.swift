//
//  NYTimesArticleDetailsViewControllerTests.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import XCTest
@testable import NewYorkTimesArticles

final class NYTimesArticleDetailsViewControllerTests: XCTestCase {
    var sut: NYTimesArticleDetailsViewController!
    var presenter: NYTimesArticleDetailsPresenterMock!
    var article: NYTimesArticle!
    
    override func setUpWithError() throws {
        presenter = NYTimesArticleDetailsPresenterMock()
        sut = NYTimesArticleDetailsViewController(presenter: presenter)
        article = NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)
        presenter.article = article
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        sut = nil
        article = nil
    }
    
    func testViewDidLoad() {
        let expect = expectation(description: "Test view did load")
        presenter.expectRequestArticleImage = expect
        sut.viewDidLoad()
        
        wait(for: [expect], timeout: 1)
    }
    
    func testNotifyArticleImage() {
        sut.articleImageView.image = nil
        XCTAssertNil(sut.articleImageView.image)
        sut.notifyArticleImage(image: UIImage())
        XCTAssertNotNil(sut.articleImageView.image)
    }
}
