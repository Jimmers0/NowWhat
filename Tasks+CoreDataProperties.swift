//
//  Tasks+CoreDataProperties.swift
//  NowWhat
//
//  Created by Jamie Randall on 3/24/18.
//  Copyright © 2018 Jamie Randall. All rights reserved.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var date: String?
}
