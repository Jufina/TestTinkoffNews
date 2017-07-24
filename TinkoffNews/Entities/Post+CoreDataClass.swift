//
//  Post+CoreDataClass.swift
//  TinkoffNews
//
//  Created by jufina on 24.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import CoreData

struct MappingProperties {
    static let id = "id"
    static let name = "name"
    static let date = "publicationDate.milliseconds"
    static let text = "text"
}

@objc(Post)
public class Post: NSManagedObject {
    
}


//MARK: - Managed

extension Post: Managed {
    static func entityName() -> String {
        if #available(iOS 10.0, *) {
            return self.entity().name!
        } else {
            return "Post"
        }
    }
}


//MARK: - Mappable

extension Post: Mappable {
    func map(from dictionary: [AnyHashable : Any]) {
        self.id = dictionary[MappingProperties.id] as? String
        self.name = dictionary[MappingProperties.name] as? String
        self.title = (dictionary[MappingProperties.text] as? String)!.tn_convertedFromHtml().string
        self.timestamp = (dictionary as NSDictionary).value(forKeyPath: MappingProperties.date) as! Double
    }
}
