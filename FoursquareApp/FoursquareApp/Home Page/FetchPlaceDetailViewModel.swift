//
//  FetchPlaceDetailViewModel.swift
//  FoursquareApp
//
//  Created by Sushanth S on 07/07/21.
//

import Foundation
import UIKit
class FetchPlaceDetailViewModel {
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
}
