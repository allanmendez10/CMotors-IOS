//
//  User+CoreDataProperties.swift
//  CMotors
//
//  Created by Allan Cordero Mendez on 8/21/20.
//  Copyright © 2020 Allan Cordero Mendez. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var img: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var status: String?
    @NSManaged public var surname: String?

}
