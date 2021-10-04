//
//  CollectionViewCell.swift
//  AppSmartTestApp
//
//  Created by Kantemir Vologirov on 10/3/21.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let avatarImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        let dimension: CGFloat = UIScreen.main.bounds.width / 2 - 40
        iv.setHeight(dimension)
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Character name"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 14)
        label.setHeight(20)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Character description"
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(avatarImage)
        avatarImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
        
        contentView.addSubview(nameLabel)
        nameLabel.anchor(top: avatarImage.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor,
                         paddingLeft: 5, paddingRight: 5)
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                paddingLeft: 5, paddingRight: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sd_cancelCurrentImageLoad()
    }
    
    // MARK: - API
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    public func configureWith(character: CharacterViewModel?) {
        guard let character = character else { return }
        avatarImage.sd_setImage(with: character.thumbnail, placeholderImage: UIImage(named: "profileIcon"))
        nameLabel.text = character.name
        descriptionLabel.text = character.description
    }
    
}
