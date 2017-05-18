//
//  Thumbnail+CoreDataProperties.swift
//  
//
//  Created by Claudio Coletta on 17/05/2017.
//
//

import Foundation
import CoreData


extension Thumbnail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Thumbnail> {
        return NSFetchRequest<Thumbnail>(entityName: "Thumbnail")
    }

    @NSManaged public var id: Double
    @NSManaged public var imageData: NSData?
    @NSManaged public var fullres: FullRes?

}
