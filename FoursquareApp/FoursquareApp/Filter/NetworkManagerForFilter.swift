//
//  NetworkManagerForFilter.swift
//  FoursquareApp
//
//  Created by Sushanth S on 13/07/21.
//

import Foundation
class NetworkManagerForFilter {
    
    func filterDetail(filterDetail: FilterDetail, landMark: String, completionHanlderL: @escaping(([PlaceDetail]) -> ())) {
            print("function called")
           
            
        guard let url = URLs.filterCityDetail(detail: filterDetail, placeName: landMark) else {
                print("wrong url")
                return
            }
           print("url === \(url)")
          
        
            
        let session = URLSession.shared.dataTask(with: url) {
                
                 data, response, error in
                    guard error == nil else {
                        print("Error: error calling POST")
                        print(error!)
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                       
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        if let data = self.parseData(data: jsonObject) {
                            completionHanlderL(data)
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Couldn't print JSON in String")
                            return
                        }
                        
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }
            session.resume()
        }
    
    func parseData(data: Any) -> [PlaceDetail]? {
        print("callledd")
        
        var placeList = [PlaceDetail]()
       
        guard let nearByPlaces = data as? [String: Any],
              let placeDetails = nearByPlaces["data"] as? [Any],
              let statuscode = nearByPlaces["status"] as? Int
        else {
            print("callledderoo")
            return nil
        }
        
        
        
        for data in placeDetails {
            
            print("data === \(data)")
                print("done")
                guard  let place = data as? [String: Any],
                      let placeid = place["id"] as? Int,
                      let placeName = place["name"] as? String,
                      let cost = place["cost"] as? Int,
                      let rating = place["overallRating"] as? Double,
                      let latitude = place["latitude"] as? Double,
                      let longitude = place["longitude"] as? Double,
                      let phone = place["phone"] as? Int,
                      let address = place["address"] as? String,
                      let overview = place["overview"] as? String,
                      let imageUrl = place["image"] as? String,
                      let placeType = place["placeType"] as? [Any]
                else {
                    
                    print("error")
                    return nil
                }
            let placeDetail = PlaceDetail(placeId: 0, placeName: "", placeType: "", rating: 0, cost: 0, phone: 0, address: "", overview: "", imageUrl: "", distance: 0, latitude: 0, longitude: 0)
                for data in placeType {
                    if let placetypeDetail = data as? [String: Any]{
               
                        if let placeid = placetypeDetail["id"] as? Int {
                  
                        }
                        if let placeType = placetypeDetail["name"] as? String {
                   
                            placeDetail.placeType = placeType
                            print("placetur===== \(placeType)")
                        }
                    
                        print(placetypeDetail)
                    }
                }
                placeDetail.placeName = placeName
                placeDetail.placeId = placeid
                placeDetail.rating = rating
                placeDetail.cost = cost
                placeDetail.phone = phone
                placeDetail.address = address
                placeDetail.overview = overview
                placeDetail.imageUrl = imageUrl
                placeDetail.latitude = latitude
                placeDetail.longitude = longitude
            
            
                print("placeid == \(placeid)")
                print("placeid == \(placeName)")
                print("placeid == \(cost)")
                print("placeid == \(rating)")
                print("placeid == \(latitude)")
                placeList.append(placeDetail)
            
        }

        return placeList

    }}
