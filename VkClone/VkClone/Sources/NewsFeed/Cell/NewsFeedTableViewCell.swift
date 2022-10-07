//
//  NewsFeedCodeTableViewCell.swift
//  VkClone
//
//  Created by Намик on 10/6/22.
//

import UIKit

protocol NewsFeedTableViewCellDelegate: AnyObject {
    func revealPost(for cell: NewsFeedTableViewCell)
}

final class NewsFeedTableViewCell: UITableViewCell {
    static let identifier = "NewsFeedTableViewCell"
    
    weak var delegate: NewsFeedTableViewCellDelegate?
    
    // Первый слой
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Второй слой
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private  let postlabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        return label
    }()
    
    private let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(UIColor.vkBlue, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    private let galleryCollectionView = GalleryCollectionView()
    
    private let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imageView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    // Третий слой на topView
    
    private let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // Третий слой на bottomView
    
    private let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Четвертый слой на bottomView
    
    private let likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    private let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    private let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    private let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768421292, green: 0.6187390685, blue: 0.664434731, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        targets()
        overlayFirstLayer() // первый слой
        overlaySecondLayer() // второй слой
        overlayThirdLayerOnTopView() // третий слой на topView
        overlayThirdLayerOnBottomView() // третий слой на bottomView
        overlayFourthLayerOnBottomViewViews() // четвертый слой на bottomViewViews
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postlabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        postlabel.frame = viewModel.sizes.postLabelFrame
        
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachements.first,
           viewModel.photoAttachements.count == 1 {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachements.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachements)
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true 
        }
    }
    
    private func targets() {
        moreTextButton.addTarget(
            self,
            action: #selector(moreTextButtonTouch),
            for: .touchUpInside
        )
    }
    
    
    @objc
    private func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    
    private func configureUI() {
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
    }
    
    private func overlayFourthLayerOnBottomViewViews() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
        helpInFourthLayer(view: likesView,
                          imageView: likesImage,
                          label: likesLabel)
        helpInFourthLayer(view: commentsView,
                          imageView: commentsImage,
                          label: commentsLabel)
        helpInFourthLayer(view: sharesView,
                          imageView: sharesImage,
                          label: sharesLabel)
        helpInFourthLayer(view: viewsView,
                          imageView: viewsImage,
                          label: viewsLabel)
    }
    
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        NSLayoutConstraint.activate([
            // imageView constraints
            imageView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 10),
            imageView.widthAnchor.constraint(
                equalToConstant: Constants.bottomViewViewsIconSize),
            imageView.heightAnchor.constraint(
                equalToConstant: Constants.bottomViewViewsIconSize),
            
            // label constraints
            label.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: 4),
            label.trailingAnchor.constraint(
                equalTo: view.trailingAnchor)
        ])
    }
    
    private func overlayThirdLayerOnBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        // likesView constraints
        likesView.anchor(
            top: bottomView.topAnchor,
            leading: bottomView.leadingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth,
                         height: Constants.bottomViewViewHeight)
        )
        
        // commentsView constraints
        commentsView.anchor(
            top: bottomView.topAnchor,
            leading: likesView.trailingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth,
                         height: Constants.bottomViewViewHeight)
        )
        
        // sharesView constraints
        sharesView.anchor(
            top: bottomView.topAnchor,
            leading: commentsView.trailingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.bottomViewViewWidth,
                         height: Constants.bottomViewViewHeight)
        )
        
        // viewsView constraints
        viewsView.anchor(
            top: bottomView.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: bottomView.trailingAnchor,
            size: CGSize(width: Constants.bottomViewViewWidth,
                         height: Constants.bottomViewViewHeight)
        )
    }
    
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            // iconImageView constraints
            iconImageView.leadingAnchor.constraint(
                equalTo: topView.leadingAnchor),
            iconImageView.topAnchor.constraint(
                equalTo: topView.topAnchor),
            iconImageView.heightAnchor.constraint(
                equalToConstant: Constants.topViewHeight),
            iconImageView.widthAnchor.constraint(
                equalToConstant: Constants.topViewHeight),
            
            // nameLabel constraints
            nameLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 8),
            nameLabel.trailingAnchor.constraint(
                equalTo: topView.trailingAnchor,
                constant: -8),
            nameLabel.topAnchor.constraint(
                equalTo: topView.topAnchor,
                constant: 2),
            nameLabel.heightAnchor.constraint(
                equalToConstant: Constants.topViewHeight / 2 - 2),
            
            // dateLabel constraints
            dateLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 8),
            dateLabel.trailingAnchor.constraint(
                equalTo: topView.trailingAnchor,
                constant: -8),
            dateLabel.bottomAnchor.constraint(
                equalTo: topView.bottomAnchor,
                constant: -2),
            dateLabel.heightAnchor.constraint(
                equalToConstant: 14)
        ])
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postlabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
                constant: 8),
            topView.trailingAnchor.constraint(
                equalTo: cardView.trailingAnchor,
                constant: -8),
            topView.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 8),
            topView.heightAnchor.constraint(
                equalToConstant: Constants.topViewHeight)
        ])
    }
    
    private func overlayFirstLayer() {
        contentView.addSubview(cardView)
        // cardView constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
