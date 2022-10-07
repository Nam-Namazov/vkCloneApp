//
//  NewsFeedViewController.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: AnyObject {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

final class NewsFeedViewController: UIViewController,
                                    NewsFeedDisplayLogic,
                                    NewsFeedTableViewCellDelegate {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    private let tableView = UITableView()
    private var feedViewModel = FeedViewModel.init(cells: [])
    private var titleView = TitleView()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(refresh),
            for: .valueChanged
        )
        return refreshControl
    }()
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = NewsFeedInteractor()
        let presenter = NewsFeedPresenter()
        let router = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        style()
        configreTableView()
        setupTopBars()
        interactor?.makeRequest(
            request: NewsFeed.Model.Request.RequestType.getNewsFeed
        )
        interactor?.makeRequest(
            request: NewsFeed.Model.Request.RequestType.getUser
        )
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            tableView.reloadData()
            refreshControl.endRefreshing()
        case .displayUser(userViewModel: let userViewModel):
            titleView.set(userViewModel: userViewModel)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNextBatch)
        }
    }
    
    private func setupTopBars() {
        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    private func configreTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            NewsFeedTableViewCell.self,
            forCellReuseIdentifier: NewsFeedTableViewCell.identifier
        )
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray5
        view.backgroundColor = .white
        let topInset: CGFloat = 8
        tableView.contentInset.top = topInset
        tableView.addSubview(refreshControl)
    }
    
    private func style() {
        view.backgroundColor = .white
    }
    
    @objc
    private func refresh() {
        interactor?.makeRequest(
            request: NewsFeed.Model.Request.RequestType.getNewsFeed
        )
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 5),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - NewsFeedTableViewCellDelegate
    func revealPost(for cell: NewsFeedTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let cellViewModel = feedViewModel.cells[indexPath.row]
        interactor?.makeRequest(request: NewsFeed
            .Model
            .Request
            .RequestType
            .revealPostIds(postId: cellViewModel.postId))
    }
}

// MARK: - UITableViewDataSource
extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsFeedTableViewCell.identifier,
            for: indexPath) as? NewsFeedTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
}
