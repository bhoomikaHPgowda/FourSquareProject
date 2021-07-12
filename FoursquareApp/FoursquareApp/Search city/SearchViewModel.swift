//
//  SearchViewModel.swift
//  FoursquareApp
//
//  Created by Sushanth S on 12/07/21.
//

import Foundation

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
}
