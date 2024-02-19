//
//  NYTimesURLsHelper.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 17/02/24.
//

import Foundation

enum APIBasePath: String {
    case nyTimes = "https://api.nytimes.com/"
}

enum Endpoint: String {
    case weekMostViewedArticles = "svc/mostpopular/v2/viewed/7.json"
}

class NYTimesURLsHelper {
    static let nyTimesWeekMostViewedArticles = (APIBasePath.nyTimes.rawValue + Endpoint.weekMostViewedArticles.rawValue)
}
