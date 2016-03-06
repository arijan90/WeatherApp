//
//  SelectCityViewController.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 5. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import UIKit

class SelectCityViewController: UIViewController {
    
    let apiKey = "546be23921ef651bb1c511c2e6477f79"
    @IBOutlet weak var selectCityTextField: UITextField!
    
    var onCitySelected : ((City) -> ())!
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveNewCity:")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func saveNewCity(sender: AnyObject) {
        let cityName = selectCityTextField.text!
        var city: City!
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=\(apiKey)&units=metric"
        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: { (data, response, error) -> Void in
//            do{
//                let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String:AnyObject]
//                
//                print(jsonResponse)
//                let id = jsonResponse["id"]!.integerValue
//                let name = jsonResponse["name"]!
//                let humidity = jsonResponse["main"]!["humidity"]!!.floatValue
//                let temperature = jsonResponse["main"]!["temp"]!!.floatValue
//                let description = "sadf"//jsonResponse["weather"]!["description"]!!
//                
//                city = City.init(id: id, name: name as! String, temperature: temperature, humidity: humidity, description: description)
//                
//                print(city)
//            }
//            catch {
//                print("json error: \(error)")
//            }
//        })
//        task.resume()
        
        // Block returning selected city
        city = City.init(id: 1234, name: "London", temperature: 20.5, humidity: 89, description: "Rainy weather")
        onCitySelected(city)
        navigationController?.popViewControllerAnimated(true)
    }
}