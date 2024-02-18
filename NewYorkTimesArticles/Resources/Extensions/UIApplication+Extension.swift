//
//  UIApplication+Extension.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

extension UIApplication {
    static func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
    }
}
