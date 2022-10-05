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

final class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var feedViewModel = FeedViewModel.init(cells: [])
    
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
        interactor?.makeRequest(
            request: NewsFeed.Model.Request.RequestType.getNewsFeed
        )
    }
    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsFeed(feedViewModel: let feedViewModel):
            self.feedViewModel = feedViewModel
            tableView.reloadData()
        }
    }
    
    private func configreTableView() {
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.register(UITableViewCell.self,
//                           forCellReuseIdentifier: "cell")
        tableView.register(
            UINib(nibName: "NewsFeedTableViewCell",
                  bundle: nil),
            forCellReuseIdentifier: NewsFeedTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        view.backgroundColor = .white
    }
    
    private func style() {
        view.backgroundColor = .white
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
        ])
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
}
