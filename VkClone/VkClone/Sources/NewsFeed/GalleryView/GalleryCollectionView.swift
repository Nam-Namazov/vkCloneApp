//
//  GalleryCollectionView.swift
//  VkClone
//
//  Created by Намик on 10/7/22.
//

import UIKit

final class GalleryCollectionView: UICollectionView {
    private var photos = [FeedCellPhotoAttachementViewModel]()
    
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        style()
        configureCollectionView()
    }
    
    func set(photos: [FeedCellPhotoAttachementViewModel]) {
        self.photos = photos
        reloadData()
    }
    
    private func style() {
        backgroundColor = .yellow
    }
    
    private func configureCollectionView() {
        delegate = self
        dataSource = self
        register(
            GalleryCollectionViewCell.self,
            forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GalleryCollectionViewCell.identifier,
            for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GalleryCollectionView: UICollectionViewDelegate {
    
}
