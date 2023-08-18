//
//  FeedsCollectionViewCell.swift
//  BlogHorizon
//
//  Created by IPH Technologies Pvt. Ltd. on 07/06/23.
//

import UIKit
class ArticleListCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var titleBlogLabel: UILabel!
    @IBOutlet weak var dateOfPublishLabel: UILabel!
    @IBOutlet weak var estimatedTimeToReadBlogLabel: UILabel!
    @IBOutlet weak var shadowImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        blogImageView.layer.cornerRadius = 10.0
        blogImageView.clipsToBounds = true
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        // Set masks to bounds to false to avoid the shadow from being clipped to the corner radius
        layer.cornerRadius = 6.0
        layer.masksToBounds = false
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        }
}
