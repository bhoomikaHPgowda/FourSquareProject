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
    
    func getHotalPhotosForCollectionView(placeID: Int, pageNo: Int, pageSize: Int, complitionHandler: @escaping(Int,[String]) -> ()) {
        networkManger.getHotelPhoto(placeID: placeID, pageNo: pageNo, pageSize: pageSize, completionHandler: {
            statusCode,images
            in
            print("network manger returned")
            complitionHandler(statusCode,images)
        })
    }
}
