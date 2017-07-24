//
//  NoDataView.swift
//  TinkoffNews
//
//  Created by jufina on 23.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

class EmptyDataView: UIView, Reusable {
    var retryActionHandler: (() -> ())?
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    class func instanceFromNib() -> EmptyDataView {
        return EmptyDataView.nib.instantiate(withOwner: nil, options: nil)[0] as! EmptyDataView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRetryButton()
    }
    
    @IBAction func retryAction(_ sender: Any) {
        retryActionHandler?()
    }
    
    func setDescription(text: String) {
        self.descriptionLabel.text = text
    }
}


//MARK: - Setup

extension EmptyDataView {
    fileprivate func setupRetryButton() {
        retryButton.layer.borderWidth = 1
        retryButton.layer.borderColor = retryButton.currentTitleColor.cgColor
    }
}
