//
//  SearchedCityTableViewCell.swift
//  FoursquareApp
//
//  Created by Sushanth S on 12/07/21.
//

import UIKit

class SearchedCityTableViewCell: UITableViewCell {
    @IBOutlet weak var addToFavourite: CustomAddToFavoriteButton!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
