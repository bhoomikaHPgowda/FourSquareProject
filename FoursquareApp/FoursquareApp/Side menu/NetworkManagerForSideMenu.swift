//
//  menuNetworkManager.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 08/07/21.
//

import Foundation
import UIKit

class NetworkManagerForSideMenu{
    
    func uploadProfilePhoto(userID: Int, token: String, imageName: String, completionHandler: @escaping(Int) -> ()) {
        
        print("function called")
        let params = [
            "userId" : "\(userID)",
            "token" : "\(token)",
            "file" : "\(imageName)"
        ]
        
        guard let url = URLs.uploadProfilepicture() else {
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
            guard let userData = data else{
                
                return
            }
            print(userData)
            do {
                
                let newData = try JSONSerialization.jsonObject(with: userData, options: [])
               print(newData)
                if let data = self?.parseGetImage(data: newData){
                 
                    completionHandler(data)
                }
            } catch {
                
                print(error.localizedDescription)
            }
        }
        session.resume()
        
    }
    
    func parseGetImage(data: Any) -> (Int){
        guard let code = data as? [String: Any],
              let statusCode = code["status"] as? Int
        else {
            return  0
        }
        return  statusCode
        
    }
    
    
}
