//
//  PostListPresenter.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation


class PostListPresenter: PostListPresenterProtocol {
    weak var view: PostListViewProtocol?
    var interactor: PostListInteractorInputProtocol?
    var router: PostListRouterProtocol?
    
    fileprivate var isRefreshing = false
    
    func setupData() {
        view?.hideEmptyDataView()
        view?.showLoading()
        interactor?.getPostsList(forced: false)
    }
    
    func viewAppeared() {
        if isRefreshing {
            view?.beginRefreshing()
        } else {
            view?.endRefreshing()
        }
    }
    
    func updateData() {
        guard !isRefreshing else {
            return
        }
        isRefreshing = true
        interactor?.getPostsList(forced: true)
    }
    
    func showDetails(for post: PostModel) {
        view?.endRefreshing()
        router?.showDetailsScreen(for: post, from: view!)
    }
}

extension PostListPresenter: PostListInteractorOutputProtocol {
    func didReceivePosts(models: [PostModel]) {
        view?.hideLoading()
        isRefreshing = false
        guard models.count != 0 else {
            view?.showEmptyDataView()
            return
        }
        view?.hideEmptyDataView()
        view?.show(posts: models)
        
    }
    
    func didReceiveError(error: ErrorType) {
        router?.showErrorAlert(on: view!, message: error.message())
    }
}
