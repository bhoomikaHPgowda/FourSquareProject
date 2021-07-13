//
//  URLs.swift
//  FoursquareApp
//
//  Created by Sushanth S on 06/07/21.
//

import Foundation
import UIKit
class URLs {

   static var instanceId = "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8089"


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

            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8089/PlaceApi/nearBy?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=7")
        } else if type == .popular {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8089/PlaceApi/nearBy?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=4")
           
        } else {
            
            return URL(string:"http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8089/PlaceApi/topPick?latitude=\(latitude)&longitude=\(longitude)&pageNo=0&pageSize=3")
           
        }
    }

    static func uploadProfilepicture(userId: Int)  -> URL? {
        return URL(string: "\(instanceId)/uploadUserImage?userId=\(userId) ")
        
    }

    static func fetchCurrentPlaceDetail(id: Int) -> URL? {
        
       return URL(string: " http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8089/PlaceApi/placeById?placeId=16")
    }
    

    static func fetchURLForAddRating() -> URL? {
        
        return URL(string: "\(instanceId)/addRating")
    }
    
    static func addOrDeleteFavourite(requestMethod: HttpRequest) -> URL? {
        if requestMethod == .addToFavourite {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8089/addFavourite")
        } else {
            return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8089/deleteFavourite")
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
    
    static func fetchFavouriteList(userId: Int) -> URL? {
        
        return URL(string: "http://ec2-3-139-63-149.us-east-2.compute.amazonaws.com:8089/getFavourite?userId=\(userId)&pageNo=0&pageSize=4")
    }
    
    static func getUserDetail(userId: Int) -> URL? {
        
        return URL(string: "\(instanceId)/getUser?userId=\(userId)")
    }
    
    static func fetchSearchedCityDetail(placeName: String) -> URL? {
    
        return URL(string: "\(instanceId)/FeatureFilters?landmark=\(placeName)&latitude=0&longitude=0&rating=False&distance=False&popular=False&radius=0&cost=0&creditCard=False&delivery=False&dog_friendly=False&family_friendly=True&outdoor=False&wifi=False&walking=False&parking=False&pageNo=0&pageSize=5")
    }
    
    static func filterCityDetail(detail: FilterDetail, placeName: String) -> URL? {
        return URL(string: "\(instanceId)/FeatureFilters?landmark=\(placeName)&latitude=0&longitude=0&rating=\(detail.rating)&distance=\(detail.distance)&popular=\(detail.popular)&radius=\(detail.radius)&cost=\(detail.cost)&creditCard=\(detail.accessToCard)&delivery=\(detail.delivery)&dog_friendly=\(detail.dogFriendly)&family_friendly=\(detail.dogFriendly)&outdoor=\(detail.outdoorSeating)&wifi=\(detail.wifi)&walking=\(detail.inWalkingDistance)&parking=\(detail.parking)&pageNo=0&pageSize=5")
    }


}
