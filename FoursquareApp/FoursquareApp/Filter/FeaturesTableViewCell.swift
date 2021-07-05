//
//  FeaturesTableViewCell.swift
//  FoursquareApp
//
//  Created by Sushanth S on 01/07/21.
//

import UIKit

class FeaturesTableViewCell: UITableViewCell {

    @IBOutlet weak var selectButton: CustomButtonforFilters!
    @IBOutlet weak var select: UIButton!
    @IBOutlet weak var featureName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func selectTapped(_ sender: CustomButtonforFilters) {
        sender.toggle()
    }
    
}
