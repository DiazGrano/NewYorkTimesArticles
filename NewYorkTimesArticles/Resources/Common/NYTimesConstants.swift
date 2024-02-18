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
        static let unknown = "-64701"
        static let badURL = "-64702"
        static let badResponseBody = "-64703"
        static let badRequestBody = "-64704"
        static let noInternet = "-64705"
        static let biometric = "-64706"
        static let whatsapp = "-64707"
        static let login = "-64708"
        static let register = "-64709"
    }
}
