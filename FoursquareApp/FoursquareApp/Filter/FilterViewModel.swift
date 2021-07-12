//
//  FilterViewModel.swift
//  FoursquareApp
//
//  Created by Sushanth S on 13/07/21.
//

import Foundation
class FilterViewModel {
    
    var networkManger = NetworkManagerForFilter()
    func filterCityDetail(filterOption: FilterDetail, landMark: String, completionHander: @escaping([PlaceDetail]) -> ()) {
        
        networkManger.filterDetail(filterDetail: filterOption, landMark: landMark, completionHanlderL: {
            filteredDetail
            in
            completionHander(filteredDetail)
        })
        
    }
}
