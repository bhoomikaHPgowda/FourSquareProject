//
//  NearYouTableViewCell.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//

import UIKit

class NearYouTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImage: UIImageView!

    @IBOutlet weak var addToFavouriteButton: CustomAddToFavoriteButton!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var dcsd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        rating?.layer.cornerRadius = 5
        rating?.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func addToFavourite(_ sender: CustomAddToFavoriteButton) {
      
    }
    
}
