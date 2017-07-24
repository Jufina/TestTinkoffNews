//
//  Post+CoreDataProperties.swift
//  TinkoffNews
//
//  Created by jufina on 24.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post");
    }

    @NSManaged public var content: String?
    @NSManaged public var timestamp: Double
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var title: String?

}
