//
//  String+Html.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func tn_convertedFromHtml() -> NSAttributedString {
        let htmlData = self.data(using: String.Encoding.unicode)
        let result = try! NSAttributedString(data: htmlData!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        
        return result
    }
}
