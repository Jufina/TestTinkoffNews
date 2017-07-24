//
//  Reusable.swift
//  TinkoffNews
//
//  Created by jufina on 23.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable: class {
    static var nib: UINib {get}
    static var reuseIdentifier: String {get}
}


extension Reusable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var reuseIdentifier: String {
        return "\(String(describing: self))Identifier"
    }
}
