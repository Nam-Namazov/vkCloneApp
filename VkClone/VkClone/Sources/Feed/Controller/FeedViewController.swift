//
//  FeedViewController.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        networkService.getFeed()
    }
    
    private func style() {
        view.backgroundColor = .white
    }
}
