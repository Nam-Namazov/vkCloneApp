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
    var photoAttachment: FeedCellPhotoAttachementViewModel? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachementViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

final class NewsFeedTableViewCell: UITableViewCell {
    static let identifier = "NewsFeedTableViewCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var shareCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
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
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame

        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
}
