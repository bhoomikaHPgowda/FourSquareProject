//
//  reviewDetails.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 10/07/21.
//

import Foundation

class ReviewDetails{
    var statusCode: Int
    var name: [String]
    var dates: [String]
    var reviews: [String]
    var profileImage: [String]
    
    init(statusCode: Int, name: [String], dates: [String], reviews: [String], profileImage: [String]) {
        self.statusCode = statusCode
        self.name = name
        self.dates = dates
        self.reviews = reviews
        self.profileImage = profileImage
    }
}
