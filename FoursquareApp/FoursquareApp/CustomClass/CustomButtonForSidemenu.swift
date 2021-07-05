//
//  CustomButtonForSidemenu.swift
//  FoursquareApp
//
//  Created by Sushanth S on 30/06/21.
//

import Foundation
import UIKit

class CustomButtonForSidemenu: UIButton {
    
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
       
        UIButton.ImageEdgeInsetsForSidemenuButton(button: self)
    }
}
