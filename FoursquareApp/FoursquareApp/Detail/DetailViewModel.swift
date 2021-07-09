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
}
