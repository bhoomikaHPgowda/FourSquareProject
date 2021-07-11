//
//  DetailViewModel.swift
//  FoursquareApp
//
//  Created by Sushanth S on 09/07/21.
//

import Foundation
class DetailViewModel {
    
    var networkManger = NetworkManagerForFetchPlaceDetail()
    
    func fetchDetails(id: Int,complitionHandler: @escaping(PlaceDetail) -> ()) {
        
        networkManger.nearMePlacedetail(id: id, completionHandler: {
            objects
            in
            print("network manger returned")
            complitionHandler(objects)
        })
        
    }
    

    func addRating(userId: Int, token: String, placeId: Int, rating: Int, completionHandler: @escaping(Int) -> ()) {
        
        networkManger.addRating(userId: userId, token: token, placeId: placeId, rating: rating, completionHandler: {
            
            statusCode
            in
            print("status code = \(statusCode)")
            completionHandler(statusCode)
        })
    
    }
    
  
    func getHotelPhotosForCollectionView(placeID: Int, pageNo: Int, pageSize: Int, complitionHandler: @escaping(Int,[String],[String]) -> ()) {
        networkManger.getHotelPhoto(placeID: placeID, pageNo: pageNo, pageSize: pageSize, completionHandler: {
            statusCode,images,dates
            in
            print("network manger returned")
            complitionHandler(statusCode,images,dates)
        })
    }
    
    func getUsersReview(placeID: Int, pageNo: Int, pageSize: Int, complitionHandler: @escaping(ReviewDetails) -> ()){
       
        networkManger.getReview(placeID: placeID, pageNo: pageNo, pageSize: pageSize, completionHandler: {
            details
            in
            
            print("network manger returned")
            complitionHandler(details)
        } )
        
    }
    
    func addUserReview(userId: Int, token: String, placeId: Int, review: String, completionHandler: @escaping(Int) -> ()){
        networkManger.addreview(userId: userId, token: token, placeId: placeId, review: review, completionHandler: {
            statusCode
            in
            
            print("network manger returned")
            completionHandler(statusCode)
        })
        
    }

}
