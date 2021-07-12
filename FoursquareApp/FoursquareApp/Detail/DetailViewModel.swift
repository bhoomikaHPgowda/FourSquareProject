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
    



    func getHotelPhotosForCollectionView(placeID: Int, pageNo: Int, pageSize: Int, complitionHandler: @escaping(PhotoDetails) -> ()) {


        networkManger.getHotelPhoto(placeID: placeID, pageNo: pageNo, pageSize: pageSize, completionHandler: {
            photoDetails
            in
            print("network manger returned")
            complitionHandler(photoDetails)
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
    
    func addUserReview(userId: String, token: String, placeId: String, review: String, completionHandler: @escaping(Int) -> ()){
        networkManger.addreview(userId: userId, token: token, placeId: placeId, review: review, completionHandler: {
            statusCode
            in
            
            print("network manger returned")
            completionHandler(statusCode)
        })
        
    }
    
    func fetchUserDetail(Id: Int, completionHandler: @escaping(UserDetail) -> ()){
        networkManger.fetchUseeDetail(userId: Id, completionHandler: {
            
            userDetail
            in
            print(userDetail)
            completionHandler(userDetail)
        })
    
    
    }

}
