//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // My API key!
        let apikey = "6jbXLwudfo8gPHXF_q-7JbrQo-jY8q0ZwZ_ZdQkgqVKfO7o9Hg3UYz0R6SygtVkJYmvElZbba5Rj-W4WY3ndVDbOb7lzVnUgbeuOhsaavBH1GGstOM8Dqpuc1hwoYHYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
        
                // Convert JSON response to a dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // Get the businesses data and convert it into an array of dictionaries for each restaurant
                let restaurants = dataDictionary["businesses"] as! [[String: Any]]
                // Escaping method so data can be used outide the closure
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    }

    
