//
//  City.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 6. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import Foundation

class City: NSObject, NSCoding {
    
    var id: Int
    var name: String
    var temperature: Float
    var humidity: Float
    var cityDescription: String
    
    required init(json: NSDictionary) {
        self.id = json["id"]!.integerValue
        self.name = json["name"]! as! String
        self.humidity = json["main"]!["humidity"]!!.floatValue
        self.temperature = json["main"]!["temp"]!!.floatValue
        self.cityDescription = json["weather"]!.objectAtIndex(0)["description"]! as! String
    }
    
    // MARK: - NSCoding
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObjectForKey("id")!.integerValue
        name = aDecoder.decodeObjectForKey("name") as! String
        humidity = aDecoder.decodeObjectForKey("humidity")!.floatValue
        temperature = aDecoder.decodeObjectForKey("temperature")!.floatValue
        cityDescription = aDecoder.decodeObjectForKey("cityDescription") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(humidity, forKey: "humidity")
        aCoder.encodeObject(temperature, forKey: "temperature")
        aCoder.encodeObject(cityDescription, forKey: "cityDescription")
    }
    
}