//
//  NewsFeedPresenter.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
        case .some:
            print(" .some Presenter")
        case .presentNewsFeed:
            print(" .presentNewsFeed Presenter")
            viewController?.displayData(viewModel: .displayNewsFeed)
        }
    }
}
