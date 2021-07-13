//
//  UILabel+extension.swift
//  FoursquareApp
//
//  Created by Sushanth S on 13/07/21.
//

import Foundation
import UIKit
extension UILabel{
    
    static func addEmailLabel(label: UILabel){
        label.frame = CGRect(x: 165, y: 180, width: 40, height: 20)
    }
    
    static func addphoneNumberLabel(label: UILabel){
        label.frame = CGRect(x: 125, y: 255, width: 130, height: 20)
    }
    
    static func addPasswordLabel(label: UILabel){
        label.frame = CGRect(x: 150, y: 325, width: 70, height: 20)
    }
    
    static func addConformPasswordLabel(label: UILabel){
        label.frame = CGRect(x: 125, y: 395, width: 130, height: 20)
    }
}
