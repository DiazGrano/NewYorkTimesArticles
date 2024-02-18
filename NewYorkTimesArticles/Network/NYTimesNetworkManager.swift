//
//  NYTimesNetworkManager.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case head = "HEAD"
}

class NYTimesNetworkManager {
    private let apiKey = "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ"
    
    func request<responseType: Decodable>(url: String,
                                          method: RequestMethod,
                                          responseType: responseType.Type,
                                          appendAPIKey: Bool,
                                          success: @escaping (_ modelResponse: responseType) -> Void,
                                          failure: @escaping (_ errorResponse: NYTimesErrorModel) -> Void) {
        let completeURL = (appendAPIKey ? appendApiKey(url: url) : url)
        request(url: completeURL, method: method) { responseData in
            guard let decodedResponse = try? JSONDecoder().decode(responseType.self, from: responseData) else {
                failure(NYTimesErrorModel.getDefaultError(type: .badResponseBody))
                return
            }
            success(decodedResponse)
        } failure: { errorResponse in
            failure(errorResponse)
        }
    }
    
    func request(url: String,
                 method: RequestMethod,
                 success: @escaping (_ responseData: Data) -> Void,
                 failure: @escaping (_ errorResponse: NYTimesErrorModel) -> Void) {
        guard let notNilURL = URL(string: url) else {
            failure(NYTimesErrorModel.getDefaultError(type: .badURL))
            return
        }
        
        var request = URLRequest(url: notNilURL)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { responseData, responseURL, error in
            guard let notNilResponseData = responseData, let httpErrorResponse = responseURL as? HTTPURLResponse else {
                guard let nsError = error as? NSError else {
                    failure(NYTimesErrorModel.getDefaultError(type: .unknown))
                    return
                }
                
                failure(NYTimesErrorModel(code: "\(nsError.code)", message: nsError.localizedDescription))
                return
            }
            
            let statusCode = httpErrorResponse.statusCode
            
            guard (200...299) ~= statusCode else {
                failure(NYTimesErrorModel(code: "\(statusCode)", message: HTTPURLResponse.localizedString(forStatusCode: statusCode)))
                return
            }
            
            success(notNilResponseData)
        }.resume()
    }
    
    func appendApiKey(url: String) -> String {
        guard var urlComponents = URLComponents(string: url) else {
            return url
        }

        urlComponents.queryItems = [URLQueryItem(name: "api-key", value: apiKey)]
        
        guard let nonNilURL = urlComponents.url else {
            return url
        }

        return nonNilURL.absoluteString
    }
}
