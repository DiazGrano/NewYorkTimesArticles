//
//  NYTimesArticleDetailsPresenterMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesArticleDetailsPresenterMock: NYTimesArticleDetailsPresenterProtocol {
    var expectRequestArticleImage: XCTestExpectation?
    var expectResponseArticleImage: XCTestExpectation?
    var expectRequestArticleData: XCTestExpectation?
    
    var article = NYTimesArticle(id: 123, publisher: "", publishedDate: "", updatedDate: "", section: "", subsection: "", author: "", title: "", abstract: "", labels: nil, media: nil)
    
    func requestArticleImage() {
        expectRequestArticleImage?.fulfill()
    }
    
    func responseArticleImage(image: UIImage?) {
        expectResponseArticleImage?.fulfill()
    }
    
    func requestArticleData() -> NewYorkTimesArticles.NYTimesArticle {
        expectRequestArticleData?.fulfill()
        return article
    }
}
