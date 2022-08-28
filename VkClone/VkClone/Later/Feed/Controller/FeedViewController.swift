//
//  FeedViewController.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        style()
    }
    
    private func fetchData() {
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else {
                return
            }
            feedResponse.items.map { feedItem in
                print(feedItem.date)
            }
        }
    }
    
    private func style() {
        view.backgroundColor = .white
    }
}
