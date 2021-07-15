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
    
    func registerUser(email: String, mobileNumber: String, password: String, completionHandler: @escaping(Int) -> ()) {
        
        networkManger.Register(email: email, mobileNumber: mobileNumber, password: password, completionHandler: {
            
            statuscode
            in
            print("network manger returned")
            completionHandler(statuscode)
        })
    }
    
    func authenticatUser(email: String, password: String, completionHandler: @escaping(UserDetail) -> ()){
        
        networkManger.authenticateUserDetail(email: email, password: password, completionHandler: {
            
            userData
            in
            print("user code==\(userData.statusCode)")
            completionHandler(userData)
        })
    }
    
    func changePassword(email: String, password: String, completionHandler: @escaping(Int) -> ()) {
        
        networkManger.updatePassword(email: email, password: password, completionHandler: {
            
            statusCode
            in
            print("network manger returned")
            completionHandler(statusCode)
        })
    }
    
   
}
