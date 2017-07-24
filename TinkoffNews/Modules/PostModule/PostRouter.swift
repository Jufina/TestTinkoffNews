//
//  PostRouter.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

class PostRouter: PostRouterProtocol {
    static func postModule(with post: PostModel) -> UIViewController {
        let view = UIStoryboard.main().instantiateViewController(withIdentifier: "PostViewController") as! PostView
        let presenter = PostPresenter()
        let interactor = PostInteractor()
        let router = PostRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.post = post
        
        interactor.presenter = presenter
        interactor.service = PostsService()
        
        return view
    }
    
    func showErrorAlert(on view: PostViewProtocol, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        if let sourceView = view as? UIViewController {
            sourceView.present(alert, animated: true, completion: nil)
        }
    }
}
