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
    
    func fetchDetails(latitude: Double, optionType: CollectionViewOptions,complitionHandler: @escaping([PlaceDetail]) -> ()) {
        print("latitide === \(latitude) recived ")
        networkManger.nearMePlacedetail(optionType: optionType, completionHandler: {
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
}
