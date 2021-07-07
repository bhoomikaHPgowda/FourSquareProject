//
//  NetworkMangerToFetchPlaceDetail.swift
//  FoursquareApp
//
//  Created by Sushanth S on 07/07/21.
//

import Foundation
class NetworkMangerToFetchPlaceDetail {
    
    func nearMePlacedetail(optionType: CollectionViewOptions,completionHandler: @escaping([PlaceDetail]) -> ()) {
      
        guard let weatherURl = URLs.urlforFetchPlace(type: optionType) else {
            
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
                  let phone = place["phone"] as? Int,
                  let address = place["address"] as? String,
                  let overview = place["overview"] as? String,
                  let imageUrl = place["image"] as? String,
                  let placeType = place["placeType"] as? [Any]
                  
            else {
                
                return nil
            }
            let fetchDetail = PlaceDetail(placeId: placeid, placeName: placeName, placeType: "", rating: rating, cost: cost, phone: phone, address: address, overview: overview, imageUrl: imageUrl, distance: distance)
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
}
