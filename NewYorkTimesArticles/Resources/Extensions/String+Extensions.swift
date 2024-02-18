//
//  String+Extensions.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 16/02/24.
//

import UIKit

extension String {
    var localized: String {
        NSLocalizedString(self, comment: " ")
    }
    
    func localizedFill(_ arguments: CVarArg...) -> String {
        let localizedSelf = self.localized
        let spots = (localizedSelf.components(separatedBy: "%@").count - 1)
        
        guard spots == arguments.count else {
            return ""
        }
        
        return String(format: localizedSelf, arguments)
    }
    
    func toStringDateWithFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = NYTimesConstants.dateFormats.rawDate
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.dateFormat = NYTimesConstants.dateFormats.beauty
        return dateFormatter.string(from: date)
    }
}
