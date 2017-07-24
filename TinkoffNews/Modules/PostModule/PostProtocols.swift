//
//  PostProtocols.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

//MARK: - View Protocol

protocol PostViewProtocol: class {
    var presenter: PostPresenterProtocol? { get set }
    
    func show(post: PostModel)
    func showLoading()
    func hideLoading()
    func showEmptyDataView()
    func hideEmptyDataView()
}

//MARK: - Presenter Protocol

protocol PostPresenterProtocol: class {
    var view: PostViewProtocol? { get set }
    var interactor: PostInteractorInputProtocol? { get set }
    var router: PostRouterProtocol? { get set }
    
    func setupData()
}


//MARK: - Interactor Protocol

protocol PostInteractorOutputProtocol: class {
    func didReceivePost(model: PostModel)
    func didReceiveError(error: ErrorType)
}

protocol PostInteractorInputProtocol: class {
    var presenter: PostInteractorOutputProtocol? { get set }
    
    func getPostDetails(model: PostModel)
}


//MARK: - Router Protocol

protocol PostRouterProtocol: class {
    static func postModule(with post: PostModel) -> UIViewController
    func showErrorAlert(on view: PostViewProtocol, message: String)
}
