//
//  CustomSearchBar.swift
//  FoursquareApp
//
//  Created by Sushanth S on 30/06/21.
//

import Foundation
import Foundation
import UIKit

class CustomSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configuration()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        configuration()
    }
    
    func configuration() {
        for subView in self.subviews
        {
            for subView1 in subView.subviews
            {

                subView1.backgroundColor = UIColor.white
               // self.compatibleSearchTextField.backgroundColor = UIColor.white
            }

        }
        
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            textfield.backgroundColor = UIColor.white
        }
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
    }

}
