//
//  menuNetworkManager.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 08/07/21.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import UIKit

class NetworkManagerForSideMenu{
    
    func uploadProfilePhoto(userID: Int, token: String, imageName: String, completionHandler: @escaping(Int) -> ()) {

        print("function called")
        let parameters = [
          [
            "key": "file",
            "src": imageName,
            "type": "file"
          ]] as [[String : Any]]
        var body = ""
        let boundary = "Boundary-\(UUID().uuidString)"
        var error: Error? = nil
        
        for param in parameters {
          if param["disabled"] == nil {
            let paramName = param["key"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = param["src"] as! String
                guard let fileData = try? NSData(contentsOfFile:paramSrc, options:[]) as Data else { return  }
              let fileContent = String(data: fileData, encoding: .utf8)!
              body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
            }
          }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)
        
        guard let url = URLs.uploadProfilepicture(userId: userID) else {
            print("wrong url")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       
        //request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        //request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData
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

