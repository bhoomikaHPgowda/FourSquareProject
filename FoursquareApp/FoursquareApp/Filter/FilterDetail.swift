//
//  FilterDetail.swift
//  FoursquareApp
//
//  Created by Sushanth S on 12/07/21.
//

import Foundation
class FilterDetail {
    
    var popular: Bool
    var distance: Bool
    var rating: Bool
    var radius: Int
    var accessToCard: Bool
    var delivery: Bool
    var dogFriendly: Bool
    var inWalkingDistance: Bool
    var outdoorSeating: Bool
    var parking: Bool
    var wifi: Bool
   
    
    init(popular: Bool, distance: Bool, rating: Bool, radius: Int, accessToCard: Bool, delivery: Bool, dogFriendly: Bool, inWalkingDistance: Bool, outdoorSeating: Bool, parking: Bool, wifi: Bool) {
        
        self.popular = popular
        self.distance = distance
        self.rating = rating
        self.radius = radius
        self.accessToCard = accessToCard
        self.delivery = delivery
        self.dogFriendly = dogFriendly
        self.inWalkingDistance = inWalkingDistance
        self.outdoorSeating = outdoorSeating
        self.parking = parking
        self.wifi = wifi
    }
}
