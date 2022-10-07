//
//  NewsFeedInteractor.swift
//  VkClone
//
//  Created by Намик on 8/27/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

final class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
            
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] revealedPostIds, feed in
                self?.presenter?.presentData(
                    response: NewsFeed
                        .Model
                        .Response
                        .ResponseType
                        .presentNewsFeed(feed: feed,
                                         revealdedPostIds: revealedPostIds)
                )
            })
            
        case .getUser:
            service?.getUser(completion: { [weak self] user in
                self?.presenter?.presentData(
                    response: NewsFeed
                        .Model
                        .Response
                        .ResponseType
                        .presentUserInfo(user: user)
                )
            })
            
        case .revealPostIds(postId: let postId):
            service?.revealPostIds(forPostId: postId, completion: { [weak self] revealedPostIds, feed in
                self?.presenter?.presentData(
                    response: NewsFeed
                        .Model
                        .Response
                        .ResponseType
                        .presentNewsFeed(feed: feed,
                                         revealdedPostIds: revealedPostIds)
                )
            })
            
        case .getNextBatch:
            service?.getNextBatch(completion: { revealedPostIds, feed in
                self.presenter?.presentData(
                    response: NewsFeed
                        .Model
                        .Response
                        .ResponseType
                        .presentNewsFeed(feed: feed,
                                         revealdedPostIds: revealedPostIds)
                )
            })
        }
    }
}
