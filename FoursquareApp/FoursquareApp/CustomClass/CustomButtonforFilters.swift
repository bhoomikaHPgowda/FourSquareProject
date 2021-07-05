//
//  CustomButtonforFilters.swift
//  FoursquareApp
//
//  Created by Sushanth S on 02/07/21.
//

import Foundation
import UIKit

class CustomButtonforFilters: UIButton {
    
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
       
        self.setImage(UIImage(systemName: "plus"), for: .normal)
        self.setImage(UIImage(named: "selected"), for: .selected)
        self.isSelected = false
    }
    
    func toggle() {
        
        self.isSelected = !self.isSelected
    }
   
}
