//
//  CommonNavigationController.swift
//  TinkoffNews
//
//  Created by jufina on 23.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

class CommonNavigationController: UINavigationController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupNavigationController()
    }
    
    fileprivate func setupNavigationController() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
}
