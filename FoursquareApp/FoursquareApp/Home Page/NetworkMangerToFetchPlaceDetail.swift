//
//  NetworkMangerToFetchPlaceDetail.swift
//  FoursquareApp
//
//  Created by Sushanth S on 07/07/21.
//

import Foundation
class NetworkMangerToFetchPlaceDetail {
    
    func nearMePlacedetail(latitude: Double, longitude: Double, optionType: CollectionViewOptions,completionHandler: @escaping([PlaceDetail]) -> ()) {
      
        guard let weatherURl = URLs.urlforFetchPlace(latitude: latitude, longitude: longitude,type: optionType) else {
            
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: weatherURl)  {
            
            [weak self]
            (data, response, error) in
            if error != nil {
                
                print(error.debugDescription)
            }
            
            guard let weatherData = data else {
                
                return
            }
            do {
                
                let newData = try JSONSerialization.jsonObject(with: weatherData, options: [])
    
                if let data = self?.popularParse(data: newData) {
                    completionHandler(data)
                }
            } catch {
                
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }

    func popularParse(data: Any) -> [PlaceDetail]? {
        
        var details = [PlaceDetail] ()
        guard let nearByPlaces = data as? [String: Any],
              let placeDetails = nearByPlaces["data"] as? [Any]
        else {
            return nil
        }
        
        for data in placeDetails {
            
           // print("data ===== \(data)")
            guard let detail = data as? [String: Any],
                  let distance = detail["distance"] as? Double,
                  let place = detail["place"] as? [String: Any],
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
                
                return nil
            }
            let fetchDetail = PlaceDetail(placeId: placeid, placeName: placeName, placeType: "", rating: rating, cost: cost, phone: phone, address: address, overview: overview, imageUrl: imageUrl, distance: distance, latitude: latitude, longitude: longitude )
            for data in placeType {
                if let placetypeDetail = data as? [String: Any]{
               
                    if let placeid = placetypeDetail["id"] as? Int {
                  
                    }
                    if let placeType = placetypeDetail["name"] as? String {
                   
                        fetchDetail.placeType = placeType
                    }
                    
                    //print(placetypeDetail)
                }
            }
            details.append(fetchDetail)
        }
        print(details.count)
        return details
    }
    
    func addOrDeleteFavourite(userId: Int, token: String, placeId: Int, requestMethod: HttpRequest, completionHandler: @escaping(Int) -> ()) {
        
        
        print("function called")
        let params = [
            "userId": "\(userId)",
            "placeId": "\(placeId)",
        ]
        
        guard let url = URLs.addOrDeleteFavourite(requestMethod: requestMethod) else {
            return
        }
        
       
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "\(requestMethod.rawValue)"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        let session = URLSession.shared.dataTask(with: request) {
            
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
                    completionHandler(self.parseRecieveMessage(data: jsonObject))
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
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
    
    func parseRecieveMessage(data: Any) -> Int {
        
        if let receivedData = data as? [String: Any] {
            
            if let statuscode = receivedData["status"] as? Int {
                
                return statuscode
            }
        }
        return 0
    }
    
    func getFavouriteList(userId: Int, token: String, completionHandler: @escaping([PlaceDetail]?, Int) -> ()) {
      print("called")
        guard let weatherURl = URLs.fetchFavouriteList(userId: userId) else {
            print("wromg")
            return
        }
        var request = URLRequest(url: weatherURl)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

       
      
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
         
            return
          }
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                
                  let (detail, statucode) = self.parseFavouriteData(data: jsonObject)
                    if let favourite = detail {
                        completionHandler(favourite, statucode)
                    } else {
                        completionHandler(nil, statucode)
                    }
                    
                 
            } catch {
                
            }
        
            print(String(data: data, encoding: .utf8)!)
                
        }

        task.resume()
    }

    func parseFavouriteData(data: Any) -> ([PlaceDetail]?, Int){
        print("callledd")
        var details = [PlaceDetail] ()
        guard let nearByPlaces = data as? [String: Any],
              let placeDetails = nearByPlaces["data"] as? [Any],
              let statuscode = nearByPlaces["status"] as? Int
        else {
            print("callledderoo")
            return (nil, 404)
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
                      let placeType = place["placeType"] as? [Any] else {
                    
                    print("error")
                    return (nil, 404)
                }
                print("placeid == \(placeid)")
                print("placeid == \(placeName)")
                print("placeid == \(cost)")
                print("placeid == \(rating)")
                print("placeid == \(latitude)")
                
                let fetchDetail = PlaceDetail(placeId: placeid, placeName: placeName, placeType: "", rating: rating, cost: cost, phone: phone, address: address, overview: overview, imageUrl: imageUrl, distance: 0, latitude: latitude, longitude: longitude)
                for data in placeType {
                    if let placetypeDetail = data as? [String: Any]{
                   
                        if let placeid = placetypeDetail["id"] as? Int {
                      
                        }
                        if let placeType = placetypeDetail["name"] as? String {
                       
                            fetchDetail.placeType = placeType
                            print("placetur===== \(placeType)")
                        }
                        
                        print(placetypeDetail)
                    }
                }
                details.append(fetchDetail)
        }
        return (details, statuscode)
    }
}
