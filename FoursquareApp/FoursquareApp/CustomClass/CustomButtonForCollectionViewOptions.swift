//
//  CustomButtonForCollectionViewOptions.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//
import Foundation
import UIKit

class CustomButtonForCollectionViewOptions: UIButton {
    
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
       
        self.setTitleColor(UIColor.colorForNormalLabel(), for: .normal)
        self.setTitleColor(UIColor.colorForHighlightedLabel(), for: .selected)
  
        self.isSelected = false
    }
    
    func toggle() {
        
        self.isSelected = !self.isSelected
    }
    
}
