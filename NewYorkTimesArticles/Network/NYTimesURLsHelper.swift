//
//  NYTimesURLsHelper.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import Foundation

enum APIBasePath: String {
    case nyTimes = "https://api.nytimes.com/"
    case google = "https://www.google.com.mx/"
}

enum Endpoint: String {
    case weekMostViewedArticles = "svc/mostpopular/v2/viewed/7.json"
}

class NYTimesURLsHelper {
    static let nyTimesWeekMostViewedArticles = (APIBasePath.nyTimes.rawValue + Endpoint.weekMostViewedArticles.rawValue)
}
