//
//  Company+CoreDataProperties.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/16/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var address: String?
    @NSManaged public var distance: Double
    @NSManaged public var id: Int
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?
    @NSManaged public var status: String?

}
