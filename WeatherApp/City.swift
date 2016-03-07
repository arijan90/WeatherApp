//
//  City.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 6. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import Foundation

class City {
    
    var id: Int
    var name: String
    var temperature: Float
    var humidity: Float
    var description: String
    
    init(json: NSDictionary) {
        self.id = json["id"]!.integerValue
        self.name = json["name"]! as! String
        self.humidity = json["main"]!["humidity"]!!.floatValue
        self.temperature = json["main"]!["temp"]!!.floatValue
        self.description = json["weather"]!.objectAtIndex(0)["description"]! as! String
    }
    
}