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

enum AlertMessages: String {
    case mailExistError = "email exist"
    case mailExistMessage = "email alredy exist please try with new email"
    case passwordMissmatch = "password missmatch"
    case enterPassword = "enter the password shown above"
    case mailNotExist = "email not found"
    case properMailid = "enter proper email to login"
    case optImproper = "OTP Improper"
    case properOTP = "plese enter proper OTP"
    case wrongPassword = "Wrong password"
}
