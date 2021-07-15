//
//  Alert+Extension.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 06/07/21.
//

import UIKit

extension UIViewController{
     func displayAlertMessage(title: String, Discription : String){
        let alert = UIAlertController(title: title, message: Discription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
