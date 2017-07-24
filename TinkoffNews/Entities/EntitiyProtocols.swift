//
//  EntitiyProtocols.swift
//  TinkoffNews
//
//  Created by jufina on 24.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation


protocol Mappable {
    func map(from dictionary: [AnyHashable : Any])
    
}

protocol Managed {
    static func entityName() -> String
}
