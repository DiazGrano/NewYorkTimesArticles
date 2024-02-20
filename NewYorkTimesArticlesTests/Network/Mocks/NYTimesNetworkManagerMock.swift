//
//  NYTimesNetworkManagerMock.swift
//  NewYorkTimesArticlesTests
//
//  Created by Luis Enrique Diaz Grano on 19/02/24.
//

import Foundation
@testable import NewYorkTimesArticles

class NYTimesNetworkManagerMock: NYTimesNetworkManager {
    var isSuccess: Bool
    var successModel: Codable?
    var errorModel: NYTimesErrorModel
    
    init(isSuccess: Bool = true, successModel: Codable? = nil, errorModel: NYTimesErrorModel = NYTimesErrorModel.getDefaultError(type: .unknown)) {
        self.isSuccess = isSuccess
        self.successModel = successModel
        self.errorModel = errorModel
    }
    
    override func request<responseType>(url: String, method: RequestMethod, responseType: responseType.Type, appendAPIKey: Bool, success: @escaping (responseType) -> Void, failure: @escaping (NYTimesErrorModel) -> Void) where responseType : Decodable {
        guard isSuccess else {
            failure(errorModel)
            return
        }
        
        guard let notNilSuccessModel = successModel, let responseData = try? JSONEncoder().encode(notNilSuccessModel) else {
            failure(NYTimesErrorModel.getDefaultError(type: .badRequestBody))
            return
        }
        
        guard let decodedResponse = try? JSONDecoder().decode(responseType.self, from: responseData) else {
            failure(NYTimesErrorModel.getDefaultError(type: .badResponseBody))
            return
        }
        
        success(decodedResponse)
    }
    
    override func request(url: String, method: RequestMethod, success: @escaping (Data) -> Void, failure: @escaping (NYTimesErrorModel) -> Void) {
        guard isSuccess else {
            failure(errorModel)
            return
        }
        
        guard let notNilSuccessModel = successModel, let responseData = try? JSONEncoder().encode(notNilSuccessModel) else {
            success(Data())
            return
        }
        
        success(responseData)
    }
}
