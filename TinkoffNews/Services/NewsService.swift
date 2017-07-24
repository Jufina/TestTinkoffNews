//
//  NewsService.swift
//  TinkoffNews
//
//  Created by jufina on 21.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import CoreData

protocol PostsServiceInterface: class {
    func loadPostsDetails(for id: String, completion: @escaping (Post, ErrorType?) -> ())
    func loadPosts(forced: Bool, completion: @escaping ([Post],ErrorType?) -> ())
}

class PostsService {
    let dataBase = CoreDataComponent()
    let networkClient = NetworkComponent()
    let parser = ParsingComponent()
}


extension PostsService: PostsServiceInterface {
    func loadPostsDetails(for id: String, completion: @escaping (Post, ErrorType?) -> ()) {
        networkClient.apiQueue.async {
            self.networkClient.loadPostsDetails(for: id, completion: { (data, error) in
                guard error == nil else {
                    completion(self.getPost(by: id)!, error)
                    
                    return
                }
                self.parser.parse(data: data!, completion: { (object, error) in
                    guard error == nil else {
                        completion(self.getPost(by: id)!, error)
                        
                        return
                    }
                    let content = (object as! NSDictionary).value(forKeyPath: "payload.content")! as! String
                    if let post = self.dataBase.find(by: id, type: Post.self) {
                        post.content = content
                    }
                    self.dataBase.save()
                    //Unwrap - post existed in list
                    completion(self.getPost(by: id)!, nil)
                })
            })
        }
    }
    
    func loadPosts(forced: Bool, completion: @escaping ([Post],ErrorType?) -> ()) {
        networkClient.apiQueue.async {
            guard !self.isPostExists() || forced else {
                completion(self.getPosts(), nil)
                
                return
            }
            self.networkClient.loadPosts { (data, error) -> () in
                guard error == nil else {
                    completion(self.getPosts(), error)
                    
                    return
                }
                self.parser.parse(data: data!, completion: { (object, error) in
                    guard error == nil else {
                        completion(self.getPosts(), error)
                        
                        return
                    }
                    let posts = (object as! NSDictionary)["payload"] as! Array<[String: Any]>
                    posts.forEach({ (item) in
                        let id = item[MappingProperties.id] as! String
                        let post = self.dataBase.find(by: id, type: Post.self) ?? self.dataBase.create(type: Post.self)
                        post.map(from: item)
                    })
                    self.dataBase.save()
                    completion(self.getPosts(), nil)
                })
            }
        }
    }

}


//MARK: - Private

extension PostsService {
    fileprivate func getPosts() -> [Post] {
        return dataBase.getAllObjects(type: Post.self, sortedBy: "timestamp", ascending: false)
    }
    
    fileprivate func getPost(by id: String) -> Post? {
        return dataBase.find(by: id, type: Post.self)
    }
    
    fileprivate func isPostExists() -> Bool {
        return getPosts().count > 0
    }
}
