//
//  NYTimesSplashInteractorMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesSplashInteractorMock: NYTimesSplashInteractorProtocol {
    var expectGetArticles: XCTestExpectation?
    
    func getArticles() {
        expectGetArticles?.fulfill()
    }
}
