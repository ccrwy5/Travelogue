//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Chris Rehagen on 5/7/19.
//  Copyright © 2019 Chris Rehagen. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var details: String?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var rawImage: NSData?
    @NSManaged public var title: String?
    @NSManaged public var trip: Trip?

}
