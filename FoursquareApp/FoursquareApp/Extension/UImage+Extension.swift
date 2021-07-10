//
//  UImage+Extension.swift
//  FoursquareApp
//
//  Created by Sushanth S on 09/07/21.
//

import Foundation
import UIKit
extension UIImage {
    
    static func restaurentImage(url: String) -> UIImage? {
        
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url)
        else {
            return UIImage()
        }
      
        return UIImage(data: data)
    }
    
    static func starButtonTappedImage() -> UIImage? {
        
        return UIImage(named: "startSelected")
    }
    
    static func starButtonNotSeletced() -> UIImage? {
        
        return UIImage(named: "Image-1")
    }
}
