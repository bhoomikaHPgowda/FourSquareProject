//
//  Constants.swift
//  FoursquareApp
//
//  Created by Sushanth S on 29/06/21.
//

import Foundation
enum CollectionViewOptions: String, CaseIterable {
    
    case nearYour = "Near You"
    case topPick = "Top pick"
    case popular = "Popular"
    case launch = "Launch"
    case coffee = "Coffee"
}

enum SideMenuOption: String {
    
    case favourite = "FavouritesViewController"
    case feedback = "FeedbackViewController"
    case aboutUs = "AboutUsViewController"
    case logout = "logout"
}

enum FeaturesList: String, CaseIterable {
    
    case acceptsCreditCards = "Accepts credit cards"
    case delivery = "Delivery"
    case dogFreindly = "Dog friendly"
    case familyFriendPlaces = "Family=friendly places"
    case inWalkingDistance = "In walking distance"
    case outdoorSearting = "OutDoor seating"
    case parking = "Parking"
    case wifi = "Wi-Fi"
}

enum SearchScreen: String {
    
    case emptyScreen = "emptyScreen"
    case searchScreen = "searchScreen"
}
