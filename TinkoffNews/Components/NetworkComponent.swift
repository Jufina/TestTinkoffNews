//
//  NetworkComponent.swift
//  TinkoffNews
//
//  Created by jufina on 21.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation

protocol NetworkInterface: class {
    func loadPosts(completion: @escaping (Data?, ErrorType?) -> ()) throws
    func loadPostsDetails(for id: String, completion: @escaping (Data?, ErrorType?) -> ()) throws
}

class NetworkComponent {
    let apiQueue = DispatchQueue(label: "com.tinkoff.posts", qos: .utility, attributes: [ ], autoreleaseFrequency: .inherit, target: nil)
}

extension NetworkComponent: NetworkInterface {
    func loadPosts(completion: @escaping (Data?, ErrorType?) -> ()) {
        let path = URL(string: Constants.API.baseUrlPath + Constants.API.listPostsPath)!
        URLSession.shared.dataTask(with: path) { (data, response, error) in
            guard error == nil else {
                completion(nil, ErrorType.network(description: error!.localizedDescription))
                return
            }
            completion(data!, nil)
        }.resume()
    }
    
    func loadPostsDetails(for id: String, completion: @escaping (Data?, ErrorType?) -> ()){
        let path = URL(string: Constants.API.baseUrlPath + String(format: Constants.API.postDetailsPath, id))!

        URLSession.shared.dataTask(with: path) { (data, response, error) in
            guard error == nil else {
                completion(nil, ErrorType.network(description: error!.localizedDescription))
                return
            }
            completion(data!, nil)
            }.resume()
    }
}
