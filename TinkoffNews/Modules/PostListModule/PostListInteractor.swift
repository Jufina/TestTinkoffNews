//
//  PostListInteractor.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation


class PostListInteractor: PostListInteractorInputProtocol {
    weak var presenter: PostListInteractorOutputProtocol?
    var service: PostsServiceInterface!
    
    func getPostsList(forced: Bool) {
        service.loadPosts(forced: forced) { (posts, error) in
            let models = self.preparedModels(posts: posts)
            DispatchQueue.main.async {
                if error != nil {
                    self.presenter?.didReceiveError(error: error!)
                }
                self.presenter?.didReceivePosts(models: models)
            }
        }
    }
    
    fileprivate func preparedModels(posts: [Post]) -> [PostModel] {
        return posts.map({ PostModel(id: $0.id!, title: $0.title!, dateString: DateConverter.timestampToDateString(time: $0.timestamp), content: $0.content?.tn_convertedFromHtml()) })
    }
}
