//
//  UIFont+Extensions.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

enum FontWeight {
    case regular
    case bold
    case italic
}

extension UIFont {
    static func getGeorgiaFont(_ size: CGFloat, weight: FontWeight = .regular) -> UIFont {
        switch weight {
        case .regular:
            return UIFont(name: "Georgia", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        case .bold:
            return UIFont(name: "Georgia-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        case .italic:
            return UIFont(name: "Georgia-Italic", size: size) ?? .systemFont(ofSize: size, weight: .light)
        }
    }
}
