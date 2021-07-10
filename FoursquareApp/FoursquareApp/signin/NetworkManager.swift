//
//  NetworkManager.swift
//  FoursquareApp
//
//  Created by Sushanth S on 06/07/21.
//

import Foundation
import UIKit
class NetworkManger {
    
    
    func Register(email: String, mobileNumber: String, password: String, completionHandler: @escaping(Int) -> ()) {
        
        print("function called")
        let params = [
            "email" : "\(email)",
            "phone" :  "\(mobileNumber)",
            "password" : "\(password)"
        ]
        
        guard let url = URLs.regiesterUserURl() else {
            print("wrong url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        let session = URLSession.shared.dataTask(with: request) {
            
            data, response, error in
            print("url is called")
            guard let errors = error as? Error else {
                
                print("\(error)")
                return
            }
            print(error)
            guard let userData = data else{
                print("error")
                return
            }
            print(userData)
            do {
                
                let newData = try JSONSerialization.jsonObject(with: userData, options: [])
               print(newData)
                
                 
                    completionHandler(self.parseData(data: newData))
                
            } catch {
                
                print(error.localizedDescription)
            }
            completionHandler(0)
        }
        session.resume()
    }
    
    func parseData(data: Any) -> Int {
        print("code-----")
        if let statusData = data as? [String: Any] {
            if let statuscode = statusData["status"] as? Int {
                print("code=====\(statuscode)")
                return statuscode
            }
        }
        return 0
    }
    
    func authenticateUserDetail(email: String, password: String, completionHandler: @escaping(UserDetail) -> ()) {
        
        let params = [
            "email" : email,
            "password" : password
        ]
        
        guard let url = URLs.authenticateUser() else {
            print("wrong url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        let session = URLSession.shared.dataTask(with: request) {
            [weak self]
            data, response, error in
            print("url is called")
            print(data)

            print(error)
         
            guard let userData = data else{
                
                return
            }
            print(userData)
            do {
                
                let newData = try JSONSerialization.jsonObject(with: userData, options: [])
               print(newData)
                if let data = self?.parseUserDetail(data: newData){
                 
                    completionHandler(data)
                }
            } catch {
                
                print(error.localizedDescription)
            }
        }
        session.resume()
        
    }
    
        func parseUserDetail(data: Any) -> UserDetail? {
            guard let userData = data as? [String: Any],
                  let statusCode = userData["status"] as? Int,
                  let message = userData["message"] as? String,
                  let userDetail = userData["data"] as? [String: Any],
                  let datas = userDetail["userData"] as? [String: Any],
                  let id = datas["id"] as? Int,
                  let email = datas["email"] as? String,
                  let imageUrl = datas["image"] as? String,
                  let username = datas["username"] as? String,
                  let token = userDetail["token"] as? String
            else {
                return nil
            }
            let logedUserDetail = UserDetail(statuscode: statusCode, message: message, id: id, imageUrl: imageUrl, email: email, token: token, userName : username)

            return logedUserDetail
        }
    
    func updatePassword(email: String, password: String, completionHandler: @escaping(Int) -> ()){
        
        print("function called")
        let params = [
            "email" : "\(email)",
            "password" : "\(password)"
        ]
        
        guard let url = URLs.changePassword() else {
            print("wrong url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let session = URLSession.shared.dataTask(with: request) {
            [weak self]
            data, response, error in
            print("url is called")
            print(error)
            
            guard let userData = data else{
                
                return
            }
            print(userData)
            do {
                
                let newData = try JSONSerialization.jsonObject(with: userData, options: [])
               print(newData)
                if let statusCode = self?.parseStatusCode(code: newData){
                    completionHandler(statusCode)
                }
            } catch {
                
                print(error.localizedDescription)
            }
        }
        session.resume()
        
    }
    
    func parseStatusCode(code: Any) -> Int{
        guard let code = code as? [String: Any],
              let statusCode = code["status"] as? Int
              
        else {
            return 0
        }
        return statusCode
    }
        
    
}
