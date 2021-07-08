//
//  PlaceDetail.swift
//  FoursquareApp
//
//  Created by Sushanth S on 07/07/21.
//

import Foundation

class PlaceDetail {
    
    var placeId: Int
    var placeName: String
    var placeType: String
    var rating: Double
    var cost: Int
    var phone: Int
    var address: String
    var overview: String
    var imageUrl: String
    var distance: Double
    var latitude: Double
    var longitude: Double
    
    
    init(placeId: Int, placeName: String, placeType: String, rating: Double, cost: Int, phone: Int, address: String, overview: String, imageUrl: String, distance: Double, latitude: Double, longitude: Double) {
        
        self.placeId = placeId
        self.placeName = placeName
        self.placeType = placeType
        self.rating = rating
        self.cost = cost
        self.phone = phone
        self.address = address
        self.overview = overview
        self.imageUrl = imageUrl
        self.distance = distance
        self.latitude = latitude
        self.longitude = longitude
    }
}
