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
    
    static func urlforFetchPlace(latitude: Double, longitude: Double, type: CollectionViewOptions ) -> URL? {

        if type == .nearYour {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/nearBy?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=7")
        } else if type == .popular {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/nearBy?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=4")
           
        } else {
            
            return URL(string:"http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/topPick?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=3")
           
        }
    }

    static func uploadProfilepicture(userId: Int)  -> URL? {
        return URL(string: "\(instanceId)/uploadUserImage?userId=\(userId) ")
        
    }

    static func fetchCurrentPlaceDetail(id: Int) -> URL? {
        
       return URL(string: " http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/placeById?placeId=16")
    }
    
    static func getHotalPhotos(placeID: Int, pageNo: Int, pageSize: Int) -> URL? {
        return URL(string: "\(instanceId)/getPictures?placeId=\(placeID)&pageNo=\(pageNo)&pageSize=\(pageSize)")
        
    }
    


}
