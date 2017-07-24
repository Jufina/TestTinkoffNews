//
//  String+HeightCalculation.swift
//  TinkoffNews
//
//  Created by jufina on 23.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func tn_height(with font: UIFont, width: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: width,
                            height: CGFloat.greatestFiniteMagnitude), options : NSStringDrawingOptions.usesLineFragmentOrigin,
                            attributes: [NSFontAttributeName: font],
                            context : nil).size.height
    }
}
