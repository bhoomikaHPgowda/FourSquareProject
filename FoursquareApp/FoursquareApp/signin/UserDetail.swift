//
//  UserDetail.swift
//  FoursquareApp
//
//  Created by Sushanth S on 07/07/21.
//

import Foundation
import UIKit
class UserDetail {
    
    var statusCode: Int
    var message: String
    var id: Int
    var imageUrl: String
    var email: String
    var token: String
    
    init(statuscode: Int, message: String, id: Int, imageUrl: String, email: String, token: String, otp: Int?) {
        
        self.statusCode = statuscode
        self.message = message
        self.id = id
        self.imageUrl = imageUrl
        self.email = email
        self.token = token
        
        
    }
}
