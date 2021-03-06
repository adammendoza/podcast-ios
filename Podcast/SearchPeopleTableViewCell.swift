//
//  SearchPeopleTableViewCell.swift
//  Podcast
//
//  Created by Kevin Greer on 3/6/17.
//  Copyright © 2017 Cornell App Development. All rights reserved.
//

import UIKit

protocol SearchPeopleTableViewDelegate: class {
    func searchPeopleTableViewCell(cell: SearchPeopleTableViewCell, didSetFollowButton toNewValue: Bool)
}

class SearchPeopleTableViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 76
    
    let imageViewPaddingX: CGFloat = 18
    let imageViewPaddingY: CGFloat = 18
    let imageViewWidth: CGFloat = 40
    let imageViewHeight: CGFloat = 40
    let imageViewLabelPadding: CGFloat = 12
    let nameLabelPaddingY: CGFloat = 22
    let nameLabelHeight: CGFloat = 17
    let detailLabelHeight: CGFloat = 15
    let followButtonPaddingX: CGFloat = 18
    let followButtonPaddingY: CGFloat = 21
    let followButtonHeight: CGFloat = 34
    let followButtonWidth: CGFloat = 73
    let separatorHeight: CGFloat = 1
    
    var profilePictureImageView: ImageView!
    var nameLabel: UILabel!
    var detailLabel: UILabel!
    var followButton: FillButton!
    var separator: UIView!
    
    var index: Int!
        
    weak var delegate: SearchPeopleTableViewDelegate?
    
    var followButtonPressed: Bool = false
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        profilePictureImageView = ImageView(frame: CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight))
        profilePictureImageView.layer.cornerRadius = imageViewHeight / 2
        profilePictureImageView.clipsToBounds = true
        contentView.addSubview(profilePictureImageView)
        
        nameLabel = UILabel()
        nameLabel.font = ._14SemiboldFont()
        contentView.addSubview(nameLabel)
        
        detailLabel = UILabel()
        detailLabel.font = ._12RegularFont()
        detailLabel.textColor = .charcoalGrey
        contentView.addSubview(detailLabel)
        
        followButton = FillButton(type: .followWhite)
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
        followButton.addTarget(self, action: #selector(didPressFollowButton), for: .touchUpInside)
        contentView.addSubview(followButton)
        
        separator = UIView()
        separator.backgroundColor = .silver
        contentView.addSubview(separator)
        
        separator.snp.makeConstraints { make in
            make.height.equalTo(separatorHeight)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(imageViewPaddingX + imageViewWidth)
            make.trailing.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profilePictureImageView.frame = CGRect(x: imageViewPaddingX, y: imageViewPaddingY, width: imageViewWidth, height: imageViewHeight)
        let nameLabelX: CGFloat = profilePictureImageView.frame.maxX + imageViewLabelPadding
        let followButtonX: CGFloat = frame.width - followButtonPaddingX - followButtonWidth
        nameLabel.frame = CGRect(x: nameLabelX, y: nameLabelPaddingY, width: followButtonX - nameLabelX, height: nameLabelHeight)
        detailLabel.frame = CGRect(x: nameLabelX, y: nameLabel.frame.maxY, width: nameLabel.frame.width, height: detailLabelHeight)
        followButton.frame = CGRect(x: followButtonX, y: followButtonPaddingY, width: followButtonWidth, height: followButtonHeight)
        separatorInset = UIEdgeInsets(top: 0, left: nameLabelX, bottom: 0, right: 0)
    }
    
    func configure(for user: User, index: Int) {
        self.index = index
        profilePictureImageView.setImageAsynchronouslyWithDefaultImage(url: user.imageURL, defaultImage: #imageLiteral(resourceName: "person"))
        profilePictureImageView.sizeToFit()
        nameLabel.text = user.firstName + " " + user.lastName
        setFollowButtonState(isFollowing: user.isFollowing)
        if user.id == System.currentUser?.id {
            followButton.isHidden = true 
        }
        detailLabel.text = "@\(user.username) • \(user.numberOfFollowers.shortString()) followers"
    }
    
    @objc func didPressFollowButton() {
        followButtonPressed = !followButtonPressed
        followButton.isSelected = followButtonPressed
        followButton.isHighlighted = followButtonPressed
        delegate?.searchPeopleTableViewCell(cell: self, didSetFollowButton: followButtonPressed)
    }
    
    func setFollowButtonState(isFollowing: Bool) {
        followButton.isSelected = isFollowing
        followButtonPressed = isFollowing
    }
}
