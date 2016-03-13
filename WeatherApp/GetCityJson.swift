//
//  getCityJson.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 7. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import Foundation

class GetCityJson {
    
    let apiKey = "546be23921ef651bb1c511c2e6477f79"
    
    static let sharedInstance = GetCityJson()
    
    /**
     * Get city response for selected city
     * - isGroup: if true get response for multiple cities
     */
    func getCity(str: String, isGroup: Bool, completion: (result: NSDictionary) -> Void) {
        var stringPreparedForURL = isGroup ? "group?id=" : "weather?q="
        stringPreparedForURL += str.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        
        let url = "http://api.openweathermap.org/data/2.5/\(stringPreparedForURL)&APPID=\(apiKey)&units=metric"
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: { (data, response, error) -> Void in
            do{
                let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String:AnyObject]
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(result: jsonResponse)
                })
            }
            catch {
                print("json error: \(error)")
            }
            })
        task.resume()
    }
}