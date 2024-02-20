//
//  NYTimesCoreDataHelperMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles
import XCTest

class NYTimesCoreDataHelperMock: NYTimesCoreDataHelper {
    var expectSaveArticles: XCTestExpectation?
    var expectGetArticles: XCTestExpectation?
    var expectGetBase64ImageByURL: XCTestExpectation?
    var expectSaveBase64ImageByURL: XCTestExpectation?
    
   override func saveArticles(model: NYTimesArticlesResponse, completion: (() -> ())? = nil) {
       expectSaveArticles?.fulfill()
       completion?()
   }
    
    override func getArticles(completion: @escaping ((NYTimesArticlesResponse?) -> ()))  {
        expectGetArticles?.fulfill()
        completion(NYTimesArticlesResponse(results: []))
    }
    
    override func getBase64ImageByURL(url: String, completion: @escaping ((String?) -> ())) {
        expectGetBase64ImageByURL?.fulfill()
        completion("image")
    }
    
    override func saveBase64ImageByURL(url: String, image: String, completion: (() -> ())? = nil) {
        expectSaveBase64ImageByURL?.fulfill()
        completion?()
    }
}
