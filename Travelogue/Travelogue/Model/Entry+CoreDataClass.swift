//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Chris Rehagen on 5/7/19.
//  Copyright © 2019 Chris Rehagen. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Entry)
public class Entry: NSManagedObject {
   
    var date: Date?{
        get{
            return rawDate as Date?
        }
        set{
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(title: String, rawDate: Date?, details: String, rawImage: NSData) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext
            else{
                return nil
        }
        
        self.init(entity: Entry.entity(), insertInto: context)
        
        self.title = title
        self.details = details
        self.rawDate = rawDate as NSDate?
        self.rawImage = rawImage
    }
}
