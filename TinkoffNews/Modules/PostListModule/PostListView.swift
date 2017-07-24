//
//  PostListView.swift
//  TinkoffNews
//
//  Created by jufina on 22.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

class PostListView: UIViewController {
    @IBOutlet weak var postsTableView: UITableView!
    fileprivate let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var emptyDataView: EmptyDataView!
    
    var presenter: PostListPresenterProtocol?
    fileprivate var posts = [PostModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingIndicator()
        setupEmptyDataView()
        setupTableView()
        setupRefreshControl()
        
        presenter?.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewAppeared()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.indicator.frame = self.view.frame
        self.indicator.center = self.view.center
    }
    
    func refreshAction() {
        presenter?.updateData()
    }
}


//MARK: - Setup

extension PostListView {
    fileprivate func setupLoadingIndicator() {
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = UIColor.white
        
        self.postsTableView.addSubview(indicator)
    }
    
    fileprivate func setupTableView() {
        self.postsTableView.dataSource = self
        self.postsTableView.delegate = self
    }
    
    fileprivate func setupEmptyDataView() {
        self.emptyDataView = EmptyDataView.instanceFromNib()
        self.emptyDataView.setDescription(text: Constants.Strings.emptyList)
        self.emptyDataView.retryActionHandler = { [unowned self] in
            self.presenter?.setupData()
        }
    }
    
    fileprivate func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
}


//MARK: - PostListViewProtocol

extension PostListView: PostListViewProtocol {
    func show(posts: [PostModel]) {
        self.posts = posts
        self.postsTableView.reloadData()
        self.postsTableView.backgroundView = refreshControl
    }
    
    func showLoading() {
        indicator.startAnimating()
    }
    
    func hideLoading() {
        refreshControl.endRefreshing()
        indicator.stopAnimating()
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func beginRefreshing() {
        self.postsTableView.setContentOffset(CGPoint(x: 0, y: -self.refreshControl.frame.height), animated: false)
        refreshControl.beginRefreshing()
    }
    
    func showEmptyDataView() {
        self.postsTableView.backgroundView = self.emptyDataView
    }
    
    func hideEmptyDataView() {
        self.postsTableView.backgroundView = nil
        self.postsTableView.backgroundView = refreshControl
    }
}


//MARK: - UITableViewDelegate, UITableViewDatasource

extension PostListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.postsTableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.reuseIdentifier) as! PostListTableViewCell
        cell.configure(with: posts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PostListTableViewCell.height(with: posts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDetails(for: posts[indexPath.row])
        self.postsTableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1 //hiding header
    }
}
