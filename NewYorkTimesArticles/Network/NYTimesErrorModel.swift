//
//  NYTimesErrorModel.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

enum NYTimesDefaultErrorType {
    case unknown
    case badURL
    case badResponseBody
    case badRequestBody
    case noInternet
    
    func getCode() -> String {
        switch self {
        case .unknown:
            return NYTimesConstants.ErrorCodes.unknown
        case .badURL:
            return NYTimesConstants.ErrorCodes.badURL
        case .badResponseBody:
            return NYTimesConstants.ErrorCodes.badResponseBody
        case .badRequestBody:
            return NYTimesConstants.ErrorCodes.badRequestBody
        case .noInternet:
            return NYTimesConstants.ErrorCodes.noInternet
        }
    }
    
    func getTitle() -> String {
        return "Alerts.title".localized
    }
    
    func getMessage() -> String {
        switch self {
        case .unknown:
            return "Network.message.unknown".localized
        case .badURL:
            return "Network.message.badURL".localized
        case .badResponseBody:
            return "Network.message.badResponseBody".localized
        case .badRequestBody:
            return "Network.message.badRequestBody".localized
        case .noInternet:
            return "Network.message.noInternet".localized
        }
    }
}

struct NYTimesErrorModel {
    let code: String
    let title: String
    let message: String
    let defaultErrorType: NYTimesDefaultErrorType?
    
    init(code: String = NYTimesDefaultErrorType.unknown.getCode(),
         title: String = NYTimesDefaultErrorType.unknown.getTitle(),
         message: String = NYTimesDefaultErrorType.unknown.getMessage()) {
        self.code = code
        self.title = title
        self.message = message
        self.defaultErrorType = nil
    }
    
    init(code: String = NYTimesDefaultErrorType.unknown.getCode(),
         title: String = NYTimesDefaultErrorType.unknown.getTitle(),
         message: String? = NYTimesDefaultErrorType.unknown.getMessage()) {
        self.code = code
        self.title = title
        self.message = message ?? NYTimesDefaultErrorType.unknown.getMessage()
        self.defaultErrorType = nil
    }
    
    init(code: String,
         title: String,
         message: String,
         defaultErrorType: NYTimesDefaultErrorType) {
        self.code = code
        self.title = title
        self.message = message
        self.defaultErrorType = defaultErrorType
    }
    
    static func getDefaultError(type: NYTimesDefaultErrorType) -> NYTimesErrorModel {
        return NYTimesErrorModel(code: type.getCode(), title: type.getTitle(), message: type.getMessage(), defaultErrorType: type)
    }
    
    func getFormattedMessage() -> String {
        return "Network.message.error".localizedFill(message, code)
    }
}
