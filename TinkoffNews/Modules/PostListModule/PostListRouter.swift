//
//  PostListRouter.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

class PostListRouter: PostListRouterProtocol {
    
    func showDetailsScreen(for post: PostModel, from view: PostListViewProtocol) {
        let detailsViewController = PostRouter.postModule(with: post)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    static func postListModule() -> UIViewController {
        let navigationController = UIStoryboard.main().instantiateViewController(withIdentifier: "CommonNavigationController") as! UINavigationController
        let view = navigationController.topViewController as! PostListView
        let presenter = PostListPresenter()
        let interactor = PostListInteractor()
        let router = PostListRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.service = PostsService()
        
        return navigationController
    }
    
    func showErrorAlert(on view: PostListViewProtocol, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        if let sourceView = view as? UIViewController {
            sourceView.present(alert, animated: true, completion: nil)
        }
    }
}
