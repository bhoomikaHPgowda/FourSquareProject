//
//  CustomAddToFavouriteButton.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//

import Foundation
import UIKit

class CustomAddToFavoriteButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configureToggleButton()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        configureToggleButton()
    }
    override func awakeFromNib() {
        configureToggleButton()
    }
    
    func configureToggleButton() {
       
        self.setImage(UIImage(named: "notFavourite"), for: .normal)
        self.setImage(UIImage(named: "favourite"), for: .selected)
        self.isSelected = false
    }
    
    func toggle() {
        
        self.isSelected = !self.isSelected
    }
    
}
