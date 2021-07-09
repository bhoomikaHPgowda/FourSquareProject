//
//  NetworkManagerForFetchPlaceDetail.swift
//  FoursquareApp
//
//  Created by Sushanth S on 09/07/21.
//

import Foundation

class NetworkManagerForFetchPlaceDetail {
    
    func nearMePlacedetail(id: Int, completionHandler: @escaping(PlaceDetail) -> ()) {
      
        guard let weatherURl = URLs.fetchCurrentPlaceDetail(id: id) else {
            
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
    
    func getHotelPhoto(placeID: Int, pageNo: Int, pageSize: Int, completionHandler: @escaping(Int,[String]) -> ()){
        
        guard let photoURL = URLs.getHotalPhotos(placeID: placeID, pageNo: pageNo, pageSize: pageSize) else {
            
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: photoURL)  {
            
            [weak self]
            (data, response, error) in
            if error != nil {
                
                print(error.debugDescription)
            }
            
            guard let photoData = data else {
                
                return
            }
            do {
                
                let newData = try JSONSerialization.jsonObject(with: photoData, options: [])
                print(newData)
                if let data = self?.parseStatusCode(code: newData) {
                    print(data.0)
                    print(data.1)
                     completionHandler(data.0, data.1)
                }
            } catch {
                
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
        
    }
    
    
    func popularParse(data: Any) -> PlaceDetail? {
        
        guard let nearByPlaces = data as? [String: Any],
              let placeDetails = nearByPlaces["data"] as? [Any]
        else {
            return nil
        }
        let fetchDetail = PlaceDetail(placeId: 0, placeName: "", placeType: "", rating: 0.0, cost: 0, phone: 0, address: "", overview: "", imageUrl: "", distance: 0, latitude: 0.0, longitude: 0.0 )
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
            fetchDetail.placeId = placeid
            fetchDetail.placeName = placeName
            fetchDetail.rating = rating
            fetchDetail.cost = cost
            fetchDetail.phone = phone
            fetchDetail.address = address
            fetchDetail.overview = overview
            fetchDetail.imageUrl = imageUrl
            fetchDetail.distance = distance
            fetchDetail.latitude = latitude
            fetchDetail.longitude = longitude
           
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
            fetchDetail
        }
        
        return fetchDetail
    }
    
    func parseStatusCode(code: Any) -> (Int,[String]){
        var images = [String]()
        guard let code = code as? [String: Any],
              let statusCode = code["status"] as? Int,
              let photosDetails =  code["data"] as? [Any]
        else {
            return (0, [""])
        }
        for photodetail in photosDetails{
            if let detail = photodetail as? [String:Any]{
                let image = detail["image"] as? String ?? "nil"
                images.append(image)
            }
            
        }
        return (statusCode, images)
    }
        
}
