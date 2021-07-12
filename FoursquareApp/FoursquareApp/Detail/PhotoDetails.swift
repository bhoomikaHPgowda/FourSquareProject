//
//  photoDetails.swift
//  FoursquareApp
//
//  Created by Bhoomika H P on 12/07/21.
//

import Foundation

class PhotoDetails{
    
    var statusCode: Int
    var image: [String]
    var date: [String]
    var userId: [Int]
    
    init(statusCode: Int, image: [String], date: [String], userId: [Int]) {
        
        self.statusCode = statusCode
        self.image = image
        self.date = date
        self.userId = userId
    }
    
}
