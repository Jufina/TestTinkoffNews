//
//  PostListProtocols.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

//MARK: - View Protocol

protocol PostListViewProtocol: class {
    var presenter: PostListPresenterProtocol? { get set }
    
    func show(posts: [PostModel])
    func showLoading()
    func hideLoading()
    func beginRefreshing()
    func endRefreshing()
    func showEmptyDataView()
    func hideEmptyDataView()
}

//MARK: - Presenter Protocol

protocol PostListPresenterProtocol: class {
    var view: PostListViewProtocol? { get set }
    var interactor: PostListInteractorInputProtocol? { get set }
    var router: PostListRouterProtocol? { get set }
    
    func setupData()
    func viewAppeared()
    func showDetails(for post: PostModel)
    func updateData()
}


//MARK: - Interactor Protocol

protocol PostListInteractorOutputProtocol: class {
    func didReceivePosts(models: [PostModel])
    func didReceiveError(error: ErrorType)
}

protocol PostListInteractorInputProtocol: class {
    var presenter: PostListInteractorOutputProtocol? { get set }
    
    func getPostsList(forced: Bool)
}


//MARK: - Router Protocol

protocol PostListRouterProtocol: class {
    static func postListModule() -> UIViewController
    
    func showDetailsScreen(for post: PostModel, from view: PostListViewProtocol)
    func showErrorAlert(on view: PostListViewProtocol, message: String)
}
