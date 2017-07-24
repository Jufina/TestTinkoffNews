//
//  PostPresenter.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation


class PostPresenter: PostPresenterProtocol {
    weak var view: PostViewProtocol?
    var interactor: PostInteractorInputProtocol?
    var router: PostRouterProtocol?
    
    var post: PostModel!
    
    func setupData() {
        view?.showLoading()
        interactor?.getPostDetails(model: post)
    }
}


//MARK: - PostInteractorOutputProtocol

extension PostPresenter: PostInteractorOutputProtocol {
    func didReceivePost(model: PostModel) {
        view?.hideLoading()
        guard model.content != nil else {
            view?.showEmptyDataView()
            
            return
        }
        view?.hideEmptyDataView()
        view?.show(post: model)
    }
    
    func didReceiveError(error: ErrorType) {
        router?.showErrorAlert(on: view!, message: error.message())
    }
}
