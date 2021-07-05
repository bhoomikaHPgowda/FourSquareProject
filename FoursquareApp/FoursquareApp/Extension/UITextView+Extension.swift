//
//  UITextView+Extension.swift
//  FoursquareApp
//
//  Created by Sushanth S on 02/07/21.
//

import Foundation
import UIKit
extension UITextView {
    
     static func addReviewTextViewSetUp(textView: UITextView) {
        
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.clipsToBounds = true
    }
}
