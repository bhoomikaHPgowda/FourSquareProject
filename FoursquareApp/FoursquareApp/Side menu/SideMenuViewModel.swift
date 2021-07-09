//
//  sideMenuViewModel.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 08/07/21.
//

import Foundation
import UIKit

class SideMenuViewModel{
    var networkManagerForSideMenu = NetworkManagerForSideMenu()
    
    func getphoto(userID: Int, token: String, imageName: String, completionHandler: @escaping(Int) -> ()) {
        print("hii")
        networkManagerForSideMenu.uploadProfilePhoto(userID: userID, token: token, imageName: imageName, completionHandler: {
            statusCode
            in
            print("network manger returned")
            completionHandler(statusCode)
        })
    }
    
    
    
}
