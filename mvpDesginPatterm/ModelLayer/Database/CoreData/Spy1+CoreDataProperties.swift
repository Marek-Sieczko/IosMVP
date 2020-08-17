//
//  Spy1+CoreDataProperties.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 16/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//
//

import Foundation
import CoreData


extension Spy1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spy1> {
        return NSFetchRequest<Spy1>(entityName: "Spy1")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var gender: String?
    @NSManaged public var isIncognito: Bool
    @NSManaged public var imageName: String?
    @NSManaged public var password: String?

}
