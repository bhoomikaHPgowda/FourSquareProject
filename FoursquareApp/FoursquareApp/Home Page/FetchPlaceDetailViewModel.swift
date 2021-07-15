//
//  FetchPlaceDetailViewModel.swift
//  FoursquareApp
//
//  Created by Sushanth S on 07/07/21.
//

import Foundation
import UIKit
class FetchPlaceDetailViewModel {
    
    var favouritePlaceList: [PlaceDetail]?
    var networkManger = NetworkMangerToFetchPlaceDetail()
    
    func fetchDetails(latitude: Double, longitude: Double, optionType: CollectionViewOptions,complitionHandler: @escaping([PlaceDetail]) -> ()) {
        print("latitide === \(latitude) recived ")
        networkManger.nearMePlacedetail(latitude: latitude, longitude: longitude, optionType: optionType, completionHandler: {
            objects
            in
            print("network manger returned")
            complitionHandler(objects)
        })
        
    }
    
    func fetchImageForGivenPlace(url: String) -> UIImage? {
        
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url)
        else {
            return nil
        }
      
        return UIImage(data: data)
    }
    
    func addOrDeleteFavourite(userId: Int, token: String, placeId: Int, requestMethod: HttpRequest, completionHandler: @escaping(Int) -> ()) {
        
        networkManger.addOrDeleteFavourite(userId: userId, token: token, placeId: placeId, requestMethod: requestMethod, completionHandler: {
            
            statusCode
            in
            print("status code = \(statusCode)")
            completionHandler(statusCode)
        })
    
    }
    
    func getFavouriteList(userId: Int, token: String, completionHandler: @escaping([PlaceDetail]?, Int) -> ()) {
        
        networkManger.getFavouriteList(userId: userId, token: token, completionHandler: {
            
            (favouirteList, statuscode)
            in
            self.favouritePlaceList = favouirteList
            print("status code = \(favouirteList?.count)")
            completionHandler(favouirteList, statuscode)
        })
    
    }
    
    func isFavourite(placeId: Int) -> Bool {
        guard let list = favouritePlaceList else {
            return false
        }
        for place in list {
            
            if place.placeId == placeId {
                return true
                
            }
        }
        return false
        
    }
    
    func favouritesListAt(index: Int) -> PlaceDetail? {
        
        if let list = favouritePlaceList {
            return list[index]
        }
        return nil
    }
    func favouirteCount() -> Int {
        
        guard  let data = favouritePlaceList else {
            return 0
        }
        return data.count
    }
    
    func removeFavourite(placeid: Int) {
        guard let details = favouritePlaceList else {
            return
        }
        for i in 0 ..< details.count {
            
            if details[i].placeId == placeid {
                favouritePlaceList?.remove(at: i)
            }
        }
    }
}
