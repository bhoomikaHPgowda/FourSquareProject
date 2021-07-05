//
//  UIFont+Extension.swift
//  FoursquareApp
//
//  Created by Sushanth S on 01/07/21.
//

import Foundation
import UIKit

extension UIFont {
    
    static func normaTextForControlSegment() ->UIFont {
        
        return UIFont(name: "Avenir-Medium", size: 18)!
    }
    
    static func boldTextForControlSegment() ->UIFont {
        
        return UIFont(name: "Avenir-Medium", size: 18.0) ?? UIFont()
    }
    
}

