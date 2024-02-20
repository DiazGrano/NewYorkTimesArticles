//
//  NYTimesArticleDetailsInteractorMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesArticleDetailsInteractorMock: NYTimesArticleDetailsInteractorProtocol {
    var expectGetArticleImage: XCTestExpectation?
    
    func getArticleImage(url: String) {
        expectGetArticleImage?.fulfill()
    }
}
