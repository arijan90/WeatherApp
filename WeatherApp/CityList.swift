//
//  CityList.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 5. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import Foundation

class CityList {
    var jsonCity: [String]!
    
    init() {
        if let path = NSBundle.mainBundle().pathForResource("city.list", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile:path)
            {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                    
                    if let name = json["name"] as? String {
                        jsonCity.append(name)
                    }
                } catch {
                    print("error serializing JSON: \(error)")
                }
            }
        }

//        // Asynchronous Http call to your api url, using NSURLSession:
//        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://api.site.com/json")!, completionHandler: { (data, response, error) -> Void in
//            // Check if data was received successfully
//            if error == nil && data != nil {
//                do {
//                    // Convert NSData to Dictionary where keys are of type String, and values are of any type
//                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String:AnyObject]
//                    // Access specific key with value of type String
//                    let str = json["key"] as! String
//                } catch {
//                    // Something went wrong
//                }
//            }
//        }).resume()
////        jsonCityArray = try NSJSONSerialization.JSONObjectWithData(JSONData, options: NSJSONReadingOptions()) as? Array
    }
    
}