//
//  NewsFeedTableViewCell.swift
//  VkClone
//
//  Created by Намик on 8/28/22.
//

import UIKit

final class NewsFeedTableViewCell: UITableViewCell {
    static let identifier = "NewsFeedTableViewCell"
    
    @IBOutlet weak var viewsCountLabel: UILabel!
    @IBOutlet weak var shareCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
