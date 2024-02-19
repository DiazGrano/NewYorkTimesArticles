//
//  ImageItem+CoreDataProperties.swift
//  
//
//  Created by Luis Enrique Diaz Grano on 18/02/24.
//
//

import Foundation
import CoreData


extension ImageItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageItem> {
        return NSFetchRequest<ImageItem>(entityName: "ImageItem")
    }

    @NSManaged public var url: String?
    @NSManaged public var imageData: String?

}
