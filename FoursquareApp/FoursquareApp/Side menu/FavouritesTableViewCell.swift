//
//  FavouritesTableViewCell.swift
//  FoursquareApp
//
//  Created by Sushanth S on 30/06/21.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteFavouriteButton: UIButton!
    @IBOutlet weak var restaurentImage: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        rating?.layer.cornerRadius = 5
        rating?.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
