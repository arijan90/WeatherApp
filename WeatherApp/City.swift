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
    
    init(id: Int, name: String, temperature: Float, humidity: Float, description: String) {
        self.id = id
        self.name = name
        self.temperature = temperature
        self.humidity = humidity
        self.description = description
    }
    
}