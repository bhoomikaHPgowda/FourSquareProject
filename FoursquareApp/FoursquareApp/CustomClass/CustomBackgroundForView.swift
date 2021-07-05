//
//  CustomClass.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 29/06/21.
//

import Foundation
import UIKit

class CustomBackgroundForView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setBackgroundforView()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setBackgroundforView()
    }
    
    func setBackgroundforView() {
        
        self.layer.contents = UIImage(named: "background")?.cgImage
    }
}
