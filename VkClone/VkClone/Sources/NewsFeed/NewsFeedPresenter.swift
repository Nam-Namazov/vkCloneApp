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

final class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    private var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    private let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
            
        case .presentNewsFeed(let feed,
                              let revealdedPostIds):
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem,
                              profiles: feed.profiles,
                              groups: feed.groups,
                              revealdedPostIds: revealdedPostIds)
            }
            
            let footerTitle = String.localizedStringWithFormat(
                NSLocalizedString("newsfeed cells count", comment: ""),
                cells.count
            )
            
            let feedViewModel = FeedViewModel.init(cells: cells,
                                                   footerTitle: footerTitle)
            viewController?.displayData(
                viewModel: NewsFeed
                    .Model
                    .ViewModel
                    .ViewModelData
                    .displayNewsFeed(feedViewModel: feedViewModel)
            )
            
        case .presentUserInfo(user: let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
            
        case .presentFooterLoader:
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayFooterLoader)
        }
    }
    
    private func cellViewModel(
        from feedItem: FeedItem,
        profiles: [Profile],
        groups: [Group],
        revealdedPostIds: [Int]
    ) -> FeedViewModel.Cell {
        
        let profile = self.profile(
            for: feedItem.sourceId,
            profiles: profiles,
            groups: groups
        )
        
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealdedPostIds.contains(feedItem.postId)
        
        let sizes = cellLayoutCalculator.sizes(
            postText: feedItem.text,
            photoAttachments: photoAttachments,
            isFullSizedPost: isFullSized
        )
        
        let postText = feedItem.text?.replacingOccurrences(
            of: "<br>",
            with: "\n"
        )
        
        return FeedViewModel.Cell.init(
            postId: feedItem.postId,
            iconUrlString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: postText,
            likes: formattedCounter(feedItem.likes?.count),
            comments: formattedCounter(feedItem.comments?.count),
            shares: formattedCounter(feedItem.reposts?.count),
            views: formattedCounter(feedItem.views?.count),
            photoAttachements: photoAttachments,
            sizes: sizes
        )
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else {
            return nil
        }
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
    
    private func profile(
        for sourseId: Int,
        profiles: [Profile],
        groups: [Group]
    ) -> ProfileRepresentable {
        
        let profilesOrGroups: [ProfileRepresentable] = sourseId >= 0 ? profiles : groups
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourseId
        }
        return profileRepresentable!
    }
    
    private func photoAttachment(
        feedItem: FeedItem
    ) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachment.init(
            photoUrlString: firstPhoto.srcBIG,
            width: firstPhoto.width,
            height: firstPhoto.height
        )
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap { attachment -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment.init(
                photoUrlString: photo.srcBIG,
                width: photo.width,
                height: photo.height
            )
        }
    }
}
