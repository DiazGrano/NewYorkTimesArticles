//
//  NYTimesArticleItem+CoreDataProperties.swift
//  NewYorkTimesArticles
//
//  Created by Luis Enrique Diaz Grano on 18/02/24.
//
//

import Foundation
import CoreData


extension NYTimesArticleItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NYTimesArticleItem> {
        return NSFetchRequest<NYTimesArticleItem>(entityName: "NYTimesArticleItem")
    }

    @NSManaged public var results: String?

}

extension NYTimesArticleItem : Identifiable {

}
