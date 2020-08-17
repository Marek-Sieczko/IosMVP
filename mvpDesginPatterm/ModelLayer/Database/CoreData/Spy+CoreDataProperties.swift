//
//  Spy+CoreDataProperties.swift
//  mvpDesginPatterm
//
//  Created by Mdo on 16/08/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//
//

import Foundation
import CoreData


extension Spy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spy> {
        return NSFetchRequest<Spy>(entityName: "Spy")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var gender: String?
    @NSManaged public var isIncognito: Bool
    @NSManaged public var imageName: String?
    @NSManaged public var password: String?

}
