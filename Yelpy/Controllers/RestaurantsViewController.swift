//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Initialize restaurantsArray
    var restaurantsArray: [[String:Any?]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getAPIData()
    }
    

    
    // Get data from API helper and retrieve restaurants
    func getAPIData(){
        API.getRestaurants() { (restaurants) in
            guard let restaurants = restaurants else {
            return
        }
        self.restaurantsArray = restaurants
        self.tableView.reloadData()
        }
    }

    
    
    // Get number of cells/restaurants
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        // Get restaurants one by one
        let restaurant = restaurantsArray[indexPath.row]
        
        // Set cell Label as name of restaurant
        cell.restaurantLabel.text = restaurant["name"] as? String ?? ""
        
        // Add restaurant image using AlamofireImage
        if let imageUrlString = restaurant["image_url"] as? String {
            let imageUrl = URL(string: imageUrlString)
            cell.restaurantImage.af.setImage(withURL: imageUrl!)
        }
        
        return cell
    }
    
    
    
}



// ––––– TODO: Create tableView Extension and TableView Functionality


