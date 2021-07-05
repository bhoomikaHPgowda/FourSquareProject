//
//  ReviewDisplayCell.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 05/07/21.
//

import Foundation
import UIKit

class ReviewDisplayCell: UITableViewCell{
    
    @IBOutlet weak var reviewerPhoto: UIImageView!
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reviewerPhoto.layer.cornerRadius = 0.5 * reviewerPhoto.bounds.size.width
    }
    
}
