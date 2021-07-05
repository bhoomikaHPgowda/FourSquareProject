//
//  UIColor+Extension.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//

import Foundation
import UIKit
extension UIColor {
    
    static func colorForLoginPageButton() -> UIColor {
        
        return .white
    }
    
    static func backgroundColorForButton() -> UIColor {
        
        return .clear
    }
    
    static func boarderColorForButton() -> UIColor {
        
        return .white
    }
    
    static func colorForHighlightedLabel() -> UIColor {
        
        return .white
    }
    
    static func grayColour() -> UIColor{
        
        return UIColor(red: 0.721, green: 0.721, blue: 0.721, alpha: 1.0)
    }
    
    static func colorForNormalLabel() -> UIColor {
        
        return UIColor(red: 135 / 255, green: 121 / 255, blue: 127 / 255, alpha: 1)
    }
    
    static func colorFoeCellSpace() -> UIColor {
        
        return UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1)
    }
    
    static func colorForControlSegmentMormalState() -> UIColor {
        
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    static func borderColorForSegmentControl() -> UIColor {
     
        return UIColor(red: 53 / 255, green: 19 / 255, blue: 71 / 255, alpha: 1)
    }
    
    static func colorForSeletedFeatureLabel() -> UIColor {
        
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    static func colorForNormalFeatureLabel() -> UIColor {
        
        return UIColor(red: 144 / 255, green: 144 / 255, blue: 144 / 255, alpha: 1)
    }
    
    
}
