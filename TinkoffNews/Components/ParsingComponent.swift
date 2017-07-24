//
//  MappingComponent.swift
//  TinkoffNews
//
//  Created by jufina on 21.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation

class ParsingComponent {
    func parse(data: Data, completion: (Any?, ErrorType?) -> ()) {
        guard let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            completion(nil, ErrorType.common)
            return
        }
        completion(object, nil)
    }
}
