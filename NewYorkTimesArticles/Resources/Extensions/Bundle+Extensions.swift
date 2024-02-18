//
//  Bundle+Extensions.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

extension Bundle {
    static var nyTimes: Bundle {
        Bundle(for: AppDelegate.self)
    }
}
