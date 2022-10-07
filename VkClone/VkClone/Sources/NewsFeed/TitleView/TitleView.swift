//
//  TitleView.swift
//  VkClone
//
//  Created by Намик on 10/7/22.
//

import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

final class TitleView: UIView {
    private var myTextField = InsetableTextField()
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .vkBlue
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myTextField)
        addSubview(myAvatarView)
        makeConstraints()
    }
    
    func set(userViewModel: TitleViewViewModel) {
        myAvatarView.set(imageURL: userViewModel.photoUrlString)
    }
    
    private func makeConstraints() {
        // myAvatarView constraints
        myAvatarView.anchor(top: topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets.init(top: 4,
                                                       left: 777,
                                                       bottom: 777,
                                                       right: 4))
        NSLayoutConstraint.activate([
            myAvatarView.heightAnchor.constraint(
                equalTo: myTextField.heightAnchor,
                multiplier: 1),
            myAvatarView.widthAnchor.constraint(
                equalTo: myTextField.heightAnchor,
                multiplier: 1)
        ])
        
        // myTextField constraints
        myTextField.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: myAvatarView.leadingAnchor,
                           padding: UIEdgeInsets.init(top: 4,
                                                      left: 4,
                                                      bottom: 4,
                                                      right: 12))
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
