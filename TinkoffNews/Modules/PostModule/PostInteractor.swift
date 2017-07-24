//
//  PostInteractor.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation


class PostInteractor: PostInteractorInputProtocol {
    weak var presenter: PostInteractorOutputProtocol?
    var service: PostsServiceInterface!
    
    func getPostDetails(model: PostModel) {
        service.loadPostsDetails(for: model.id) { (post, error) in
            let updatedModel = PostModel(id: post.id!, title: post.title!, dateString: DateConverter.timestampToDateString(time: post.timestamp), content: post.content?.tn_convertedFromHtml())
            DispatchQueue.main.async {
                if error != nil {
                    self.presenter?.didReceiveError(error: error!)
                }
                self.presenter?.didReceivePost(model: updatedModel)
            }
        }
    }
}
