//
//  CustomButton.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 29/06/21.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        buttonConfiguration()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        buttonConfiguration()
    }
    
    func buttonConfiguration() {
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
    }
}
