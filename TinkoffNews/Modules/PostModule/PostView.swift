//
//  PostView.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

class PostView: UIViewController {
    var presenter: PostPresenterProtocol?
    
    @IBOutlet weak var detailsTextView: UITextView!
    fileprivate let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate var emptyDataView: EmptyDataView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmptyDataView()
        setupLoadingIndicator()
        presenter?.setupData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.indicator.frame = self.view.frame
        self.indicator.center = self.view.center
    }
    
    fileprivate func formattedText(from post: PostModel) -> NSAttributedString {
        let text = NSMutableAttributedString(string: post.title+"\n\n", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)])
        let textPart = post.content?.tn_increaseFontSize(coefficient: 1.5)
        text.append(textPart!)
        
        return text
    }
}


//MARK: - Setup

extension PostView {
    fileprivate func setupLoadingIndicator() {
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = UIColor.white
        self.detailsTextView.addSubview(indicator)
    }
    
    fileprivate func setupEmptyDataView() {
        self.emptyDataView = EmptyDataView.instanceFromNib()
        self.emptyDataView.frame = self.view.frame
        self.emptyDataView.setDescription(text: Constants.Strings.emptyDetails)
        self.emptyDataView.retryActionHandler = { [unowned self] in
            self.presenter?.setupData()
        }
    }
}


//MARK: - PostViewProtocol

extension PostView: PostViewProtocol {
    func showLoading() {
        indicator.startAnimating()
    }
    
    func hideLoading() {
        indicator.stopAnimating()
    }
    
    func show(post: PostModel) {
        self.detailsTextView.attributedText = formattedText(from: post)
    }
    
    func showEmptyDataView() {
        view.insertSubview(self.emptyDataView, aboveSubview: self.detailsTextView)
    }
    
    func hideEmptyDataView() {
        self.emptyDataView.removeFromSuperview()
    }
}
