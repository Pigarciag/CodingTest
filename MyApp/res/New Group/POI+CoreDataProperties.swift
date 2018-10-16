//
//  POI+CoreDataProperties.swift
//  
//
//  Created by Pilar on 15/10/18.
//
//

import Foundation
import CoreData


extension POI {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<POI> {
        return NSFetchRequest<POI>(entityName: "POI")
    }

    @NSManaged public var address: String?
    @NSManaged public var contact: String?
    @NSManaged public var coordinates: String?
    @NSManaged public var id: NSNumber?
    @NSManaged public var poiDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var transport: String?
    @NSManaged public var url: String?

}
