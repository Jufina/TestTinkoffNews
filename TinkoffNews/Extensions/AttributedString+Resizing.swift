//
//  AttributedString+Resizing.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    func tn_increaseFontSize(coefficient: CGFloat) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: self)
        text.enumerateAttributes(in: NSRange(location: 0, length: text.length), options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (attribute, range, finished) in
            let oldFont = attribute[NSFontAttributeName]! as! UIFont
            let newFont = UIFont(name: oldFont.fontName, size: oldFont.pointSize*coefficient)!
            text.removeAttribute(NSFontAttributeName, range: range)
            text.addAttribute(NSFontAttributeName, value: newFont, range: range)
        }
        
        return text
    }
}
