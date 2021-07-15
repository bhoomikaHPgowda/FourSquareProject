//
//  SearchViewModel.swift
//  FoursquareApp
//
//  Created by Sushanth S on 12/07/21.
//

import Foundation
import UIKit

class SearchViewModel {
    
    var networkManager = NetworkManagerForSearch()
    func fetchSearchedCityDetail(placeName: String, completionHanlderL: @escaping(([PlaceDetail]) -> ())) {
        
        networkManager.searchPlacedetail(placeName: placeName, completionHanlderL: {
            photoDetails
            in
            print("data is fetched")
            completionHanlderL(photoDetails)
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
