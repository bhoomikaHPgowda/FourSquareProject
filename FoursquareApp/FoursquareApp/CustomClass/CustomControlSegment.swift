//
//  CustomControlSegment.swift
//  FoursquareApp
//
//  Created by Sushanth S on 01/07/21.
//

import Foundation
import UIKit

class CustomControlSegment: UISegmentedControl {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        configuration()
    }
    private func imageWithColor(color: UIColor) -> UIImage {
            let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            context!.setFillColor(color.cgColor);
            context!.fill(rect);
            let image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image!
        }
    
    func configuration() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.borderColorForSegmentControl().cgColor
        
        let normalTextAttributes: [NSAttributedString.Key : AnyObject] = [
            NSAttributedString.Key.foregroundColor: UIColor.black .withAlphaComponent(1.0),
            NSAttributedString.Key.font: UIFont.normaTextForControlSegment()
        ]

        let boldTextAttributes: [NSAttributedString.Key  : AnyObject] = [
            NSAttributedString.Key.foregroundColor: UIColor.white .withAlphaComponent(1.0),
            NSAttributedString.Key.font : UIFont.boldTextForControlSegment(),
        ]

        

        self.setTitleTextAttributes(normalTextAttributes, for: .normal)
        self.setTitleTextAttributes(normalTextAttributes, for: .highlighted)
        self.setTitleTextAttributes(boldTextAttributes, for: .selected)
   
      
    }
    
   

//        // create a 1x1 image with this color
//         func imageWithColor(color: UIColor) -> UIImage {
//            let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
//            UIGraphicsBeginImageContext(rect.size)
//            let context = UIGraphicsGetCurrentContext()
//            context!.setFillColor(color.cgColor);
//            context!.fill(rect);
//            let image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            return image!
//        }
    
    

}
