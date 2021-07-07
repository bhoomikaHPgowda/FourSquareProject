//
//  LoginViewModel.swift
//  FoursquareApp
//
//  Created by Sushanth S on 06/07/21.
//

import Foundation
import UIKit
class LoginViewModel {
    var networkManger = NetworkManger()
    func registerUser(email: String, mobileNumber: String, password: String, completionHandler: @escaping() -> ()) {
        
        networkManger.Register(email: email, mobileNumber: mobileNumber, password: password, completionHandler: {
            ()
            in
            print("network manger returned")
            completionHandler()
        })
    }
    
    func authenticatUser(email: String, password: String, completionHandler: @escaping(UserDetail) -> ()){
        
        networkManger.authenticateUserDetail(email: email, password: password, completionHandler: {
            userData
            in
            completionHandler(userData)
        })
    }
}
