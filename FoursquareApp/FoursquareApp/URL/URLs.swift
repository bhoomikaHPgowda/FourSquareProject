//
//  URLs.swift
//  FoursquareApp
//
//  Created by Sushanth S on 06/07/21.
//

import Foundation
import UIKit
class URLs {
   static var instanceId = "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080"

    static func regiesterUserURl() -> URL? {
        return URL(string: "\(instanceId)/register")
    }
    
    static func authenticateUser() -> URL? {
        
        return URL(string: "\(instanceId)/authenticate")
    }
    
    static func changePassword() -> URL? {
    
        return URL(string: "\(instanceId)/changePassword")
    }
    
    static func urlforFetchPlace(type: CollectionViewOptions ) -> URL? {
        
        if type == .nearYour {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/nearBy?latitude=13.343528531501212&longitude=74.74668065517001&pageNo=0&pageSize=7")
        } else if type == .popular {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/nearBy?latitude=13.343528531501212&longitude=74.74668065517001&pageNo=0&pageSize=4")
           
        } else {
            
            return URL(string:"http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/topPick?latitude=13.371324&longitude=74.760691&pageNo=0&pageSize=3")
           
        }
        
    }
    
    static func uploadProfilepicture()  -> URL? {
        return URL(string: "\(instanceId)/uploadUserImage?userId=155")
        
    }

}
