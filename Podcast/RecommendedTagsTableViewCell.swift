//
//  RecommendedTagsTableViewCell.swift
//  Podcast
//
//  Created by Kevin Greer on 2/19/17.
//  Copyright © 2017 Cornell App Development. All rights reserved.
//

import UIKit

protocol RecommendedTagsTableViewCellDataSource {
    func recommendedTagsTableViewCell(dataForItemAt indexPath: IndexPath) -> String
    func numberOfRecommendedTags() -> Int
}

protocol RecommendedTagsTableViewCellDelegate{
    func recommendedTagsTableViewCell(didSelectItemAt indexPath: IndexPath)
}

class RecommendedTagsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var iconView: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var collectionView: UICollectionView!
    var dataSource: RecommendedTagsTableViewCellDataSource?
    var delegate: RecommendedTagsTableViewCellDelegate?
    
    let TitleLabelText = "Keep informed"
    let DescriptionLabelText = "Find podcasts that everyone is currently talking about."
    let kIconViewBorderPadding: CGFloat = 20
    let kIconViewLength: CGFloat = 24
    let kIconViewContentPadding: CGFloat = 10
    let kTitleDescriptionLabelPadding: CGFloat = 8
    let kDescriptionCollectionViewPadding: CGFloat = 20
    let kCollectionViewHeight: CGFloat = 34
    let kDescriptionLabelHeight: CGFloat = 34
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconView = UIImageView()
        iconView.image = #imageLiteral(resourceName: "trending")
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: UIFontWeightSemibold)
        titleLabel.text = TitleLabelText
        descriptionLabel = UILabel()
        descriptionLabel.font = .systemFont(ofSize: 14, weight: UIFontWeightRegular)
        descriptionLabel.text = DescriptionLabelText
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .left
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: RecommendedTagsCollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendedTagsCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        backgroundColor = .podcastWhite
        contentView.addSubview(collectionView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(iconView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfRecommendedTags() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecommendedTagsCollectionViewCell
        cell.tagLabel.text = dataSource?.recommendedTagsTableViewCell(dataForItemAt: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.font = RecommendedTagsCollectionViewCell.CellFont
        label.text = dataSource?.recommendedTagsTableViewCell(dataForItemAt: indexPath)
        label.sizeToFit()
        return CGSize(width: label.frame.width + 16, height: label.frame.height + 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendedTagsTableViewCell(didSelectItemAt: indexPath)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.frame = CGRect(x: kIconViewBorderPadding, y: kIconViewBorderPadding, width: kIconViewLength, height: kIconViewLength)
        titleLabel.frame = CGRect(x: iconView.frame.maxX + kIconViewContentPadding, y: iconView.frame.minY, width: 0, height: 0)
        titleLabel.sizeToFit()
        descriptionLabel.frame = CGRect(x: titleLabel.frame.minX, y: titleLabel.frame.maxY + kTitleDescriptionLabelPadding, width: frame.width-titleLabel.frame.minX-kIconViewBorderPadding, height: kDescriptionLabelHeight)
        collectionView.frame = CGRect(x: 0, y: descriptionLabel.frame.maxY + kDescriptionCollectionViewPadding, width: frame.width, height: kCollectionViewHeight)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: titleLabel.frame.minX, bottom: 0, right: kIconViewBorderPadding)
        collectionView.layoutSubviews()
        collectionView.setNeedsLayout()
    }
}
