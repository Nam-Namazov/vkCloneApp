//
//  NewsFeedTableViewCell.swift
//  VkClone
//
//  Created by Намик on 8/28/22.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
}

final class NewsFeedTableViewCell: UITableViewCell {
    static let identifier = "NewsFeedTableViewCell"
    
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var shareCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesCountLabel.text = viewModel.likes
        commentCountLabel.text = viewModel.comments
        shareCountLabel.text = viewModel.shares
        viewsCountLabel.text = viewModel.views
    }
}
