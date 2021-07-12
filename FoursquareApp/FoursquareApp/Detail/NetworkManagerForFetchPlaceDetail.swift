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
    
    func getHotelPhoto(placeID: Int, pageNo: Int, pageSize: Int, completionHandler: @escaping(PhotoDetails) -> ()){
        
        guard let photoURL = URLs.getHotelPhotos(placeID: placeID, pageNo: pageNo, pageSize: pageSize) else {
            
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
                if let data = self?.parsePhotoDetails(code: newData) {
                    
                    completionHandler(data)
                }
            } catch {
                
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
        
    }
    
    func getReview(placeID: Int, pageNo: Int, pageSize: Int, completionHandler: @escaping(ReviewDetails) -> ()) {
        
        guard let reviewURL = URLs.getReview(placeID: placeID, pageNo: pageNo, pageSize: pageSize)
        
        else {
         
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: reviewURL)  {
            
            [weak self]
            (data, response, error) in
            if error != nil {
                
                print(error.debugDescription)
            }
            
            guard let reviewData = data else {
                
                return
            }
            do {
                
                let newData = try JSONSerialization.jsonObject(with: reviewData, options: [])
                print(newData)
               
                if let data = self?.parseReviewData(code: newData) {
                    completionHandler(data)
                    
                }
            } catch {
                
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    
    func popularParse(data: Any) -> PlaceDetail? {
        
        guard let nearByPlaces = data as? [String: Any],
              let placeDetails = nearByPlaces["data"] as? [String: Any],
              let name = placeDetails["name"] as? String,
              let placeId = placeDetails["id"] as? Int,
              let placeName = placeDetails["name"] as? String,
              let cost = placeDetails["cost"] as? Int,
              let rating = placeDetails["overallRating"] as? Double,
              let latitude = placeDetails["latitude"] as? Double,
              let longitude = placeDetails["longitude"] as? Double,
              let phone = placeDetails["phone"] as? Int,
              let address = placeDetails["address"] as? String,
              let overview = placeDetails["overview"] as? String,
              let imageUrl = placeDetails["image"] as? String
        else {
            return nil
        }
       
        let fetchDetail = PlaceDetail(placeId: 0, placeName: "", placeType: "", rating: 0.0, cost: 0, phone: 0, address: "", overview: "", imageUrl: "", distance: 0, latitude: latitude, longitude: longitude)
    
        fetchDetail.placeId = placeId
        fetchDetail.placeName = placeName
        fetchDetail.rating = rating
        fetchDetail.cost = cost
        fetchDetail.phone = phone
        fetchDetail.address = address
        fetchDetail.overview = overview
        fetchDetail.imageUrl = imageUrl
        fetchDetail.distance = 0
        fetchDetail.latitude = latitude
        fetchDetail.longitude = longitude
            
           

        return fetchDetail
    }
    
    func addRating(userId: Int, token: String, placeId: Int, rating: Int, completionHandler: @escaping(Int) -> ()) {
        
        print("function called")
        let params = [
            "userId": "\(userId)",
            "placeId": "\(placeId)",
            "rating": "\(rating)"
        ]
        
        guard let url = URLs.fetchURLForAddRating() else {
            print("wrong url")
            return
        }
        
      
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
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
    
    func addToFavourite(userId: Int, token: String, placeId: Int, completionHandler: @escaping(Int) -> ()) {
        
        
        print("function called")
        let params = [
            "userId": "\(userId)",
            "placeId": "\(placeId)",
        ]
        
        guard let url = URLs.addOrDeleteFavourite(requestMethod: .addToFavourite) else {
            print("wrong url")
            return
        }
        
      
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
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
    
    func addreview(userId: String, token: String, placeId: String, review: String, completionHandler: @escaping(Int) -> ()) {
        print(userId)
        print(token)
        print(placeId)
        print(review)
        print("function called")
       let params = [
           "userId":userId,
            "placeId":placeId,
            "review":review
       ]
       
        guard let url = URLs.addReview() else {
           print("wrong url")
           return
       }
       
     
       var request = URLRequest(url: url)
       request.addValue(token, forHTTPHeaderField: "Authorization")
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       request.httpMethod = "POST"
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
    


    func parsePhotoDetails(code: Any) -> PhotoDetails? {

        var images = [String]()
        var dates = [String]()
        var userId = [Int]()
        guard let code = code as? [String: Any],
              let statusCode = code["status"] as? Int,
              let photosDetails =  code["data"] as? [Any]
        else {
            return nil
        }
        for photodetail in photosDetails{
            if let detail = photodetail as? [String:Any]{
                let image = detail["image"] as? String ?? "nil"
                images.append(image)
            }
            if let dateils = photodetail as? [String:Any]{
                let date = dateils["date"] as? String ?? "nil"
                dates.append(date)
            }
            
            if let dateils = photodetail as? [String:Any]{
                let id = dateils["user_id"] as? Int ?? 0
                userId.append(id)
            }
            
        }
        let photoDetails = PhotoDetails(statusCode: 0, image: [""], date: [""], userId: [0])
        photoDetails.statusCode = statusCode
        photoDetails.image = images
        photoDetails.date = dates
        photoDetails.userId = userId
        return photoDetails
    }
    
    
    
    
    func fetchUseeDetail(userId: Int, completionHandler: @escaping(UserDetail) -> ()) {
      print("called")
        guard let weatherURl = URLs.getUserDetail(userId: userId) else {
            print("wromg")
            return
        }
        var token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMjM0NUBnbWFpbC5jb20iLCJleHAiOjE2MjYwNDIxMjEsImlhdCI6MTYyNjAyNDEyMX0.CM-4MS7ix6MZ9kjumwbqVJXtgT3kg0-UJUhnWzP4sunZn7vrxN5k27iILdZ2bTqGJO1mc6qDrOSLzWlga4KJGA"
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
                if let data = self.parseUserDetail(data: jsonObject) {
                    completionHandler(data)
                }
                 
                    
                 
            } catch {
                
            }
        
            print(String(data: data, encoding: .utf8)!)
                
        }

        task.resume()
    }
    
    func parseUserDetail(data: Any) -> UserDetail? {
        guard let userData = data as? [String: Any],
              let statusCode = userData["status"] as? Int,
              let message = userData["message"] as? String,
              let userDetail = userData["data"] as? [String: Any],
              let id = userDetail["id"] as? Int,
              let email = userDetail["email"] as? String,
              let imageUrl = userDetail["image"] as? String,
              let username = userDetail["username"] as? String
          
        
        
        else {
            print("error")
            return nil
        }
        print(statusCode)
        let logedUserDetail = UserDetail(statuscode: statusCode, message: message, id: id, imageUrl: imageUrl, email: email, token: "", userName: username)
        print("name == \(username)")
        return logedUserDetail
    }
    
    func parseReviewData(code:Any) -> ReviewDetails? {
        guard let code = code as? [String: Any],
              let statusCode = code["status"] as? Int,
              let reviewDetails =  code["data"] as? [Any]
        else{
            return nil
        }
        print("StatusCode = \(statusCode) ")
        var userNames = [String]()
        var userReviews = [String]()
        var images = [String]()
        var dates = [String]()
        for reviewDetail in reviewDetails{
           if let detail = reviewDetail as? [String:Any] {
               let names = detail["userName"] as? String ?? "nil"
               userNames.append(names)
               let review = detail["review"] as? String ?? "nil"
               userReviews.append(review)
               let image = detail["userImage"] as? String ?? "nil"
               images.append(image)
               let reviewDate = detail["date"] as? String ?? "nil"
               dates.append(reviewDate)
           }
       }
        print(userNames)
        print(userReviews)
        print(images)
        print(dates)
        let hotelReviewDetails = ReviewDetails(statusCode: 0, name: [""], dates: [""], reviews: [""], profileImage: [""])
        hotelReviewDetails.statusCode = statusCode
        hotelReviewDetails.name = userNames
        hotelReviewDetails.reviews = userReviews
        hotelReviewDetails.profileImage = images
        hotelReviewDetails.dates = dates

        return hotelReviewDetails
    }
}
    
