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


        if type == .nearMe {

            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8088/PlaceApi/nearBy?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=7")
        } else if type == .popular {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8088/PlaceApi/nearBy?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=4")
           
        } else {
            
            return URL(string:"http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8088/PlaceApi/topPick?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=3")
           
        }
    }

    static func uploadProfilepicture(userId: Int)  -> URL? {
        return URL(string: "\(instanceId)/uploadUserImage?userId=\(userId) ")
        
    }

    static func fetchCurrentPlaceDetail(id: Int) -> URL? {
        
       return URL(string: " http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8088/PlaceApi/placeById?placeId=16")
    }
    

    static func fetchURLForAddRating() -> URL? {
        
        return URL(string: "\(instanceId)/addRating")
    }
    
    static func addOrDeleteFavourite(requestMethod: HttpRequest) -> URL? {
        if requestMethod == .addToFavourite {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8088/addFavourite")
        } else {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8088/deleteFavourite")
        }
    }
    
    static func getHotelPhotos(placeID: Int, pageNo: Int, pageSize: Int) -> URL? {
        return URL(string: "\(instanceId)/getPictures?placeId=\(placeID)&pageNo=\(pageNo)&pageSize=\(pageSize)")
    }
    
    
    static func getReview(placeID: Int, pageNo: Int, pageSize: Int) -> URL? {
        return URL(string: "\(instanceId)/reviews?PlaceId=\(placeID)&pageNo=\(pageNo)&pageSize=\(pageSize)")
    
    }
    
    static func addReview() -> URL? {
        return URL(string: "\(instanceId)/addReview")
    }
    



}
