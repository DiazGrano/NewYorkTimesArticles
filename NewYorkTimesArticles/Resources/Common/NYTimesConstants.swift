//
//  NYTimesConstants.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

enum NYTimesConstants {
    enum lotties {
        static let dotLoader = "DotLoader"
    }
    
    enum images {
        static let nyTimesTitleLogo = "NYTimesTitleLogo"
        static let defaultPhoto = "photo"
    }
    
    enum dateFormats {
        static let rawDate = "yyyy-MM-dd"
        static let beauty = "LLL dd, yyyy"
    }

    enum ErrorCodes {
        static let unknown = "-000001"
        static let badURL = "-000002"
        static let badResponseBody = "-000003"
        static let badRequestBody = "-000004"
        static let noInternet = "-000005"
    }
}
