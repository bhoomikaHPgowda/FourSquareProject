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
<<<<<<< HEAD

    static func urlforFetchPlace(latitude: Double, longitude: Double, type: CollectionViewOptions ) -> URL? {
=======
    
    static func changePassword() -> URL? {
    
        return URL(string: "\(instanceId)/changePassword")
    }
    
    static func urlforFetchPlace(type: CollectionViewOptions ) -> URL? {
>>>>>>> 62b66de2d707d4f5dc4e317df72c59aeb5d4fa34
        
        if type == .nearYour {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/nearBy?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=7")
        } else if type == .popular {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/nearBy?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=4")
           
        } else {
            
            return URL(string:"http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/topPick?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=3")
           
        }
        
    }
<<<<<<< HEAD

=======
>>>>>>> 62b66de2d707d4f5dc4e317df72c59aeb5d4fa34
    
    static func uploadProfilepicture()  -> URL? {
        return URL(string: "\(instanceId)/uploadUserImage?userId=155")
        
    }
<<<<<<< HEAD
    
    static func fetchCurrentPlaceDetail(id: Int) -> URL? {
        
       return URL(string: " http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8080/PlaceApi/placeById?placeId=16")
    }
    
=======
>>>>>>> 62b66de2d707d4f5dc4e317df72c59aeb5d4fa34

}
