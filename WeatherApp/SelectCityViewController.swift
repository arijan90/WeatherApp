//
//  SelectCityViewController.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 5. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import UIKit

class SelectCityViewController: UIViewController, UITextFieldDelegate {
    
    let apiKey = "546be23921ef651bb1c511c2e6477f79"
    @IBOutlet weak var selectCityTextField: UITextField!
    
    var onCitySelected : ((City) -> ())!
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveNewCity:")
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.enabled = false
        
        selectCityTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func textFieldDidChange(textField: UITextField) {
        let inputText = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        navigationItem.rightBarButtonItem?.enabled = inputText.characters.count > 0 ? true : false
    }
    
    func saveNewCity(sender: AnyObject) {
        let cityName = selectCityTextField.text!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        
        var city: City!
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=\(apiKey)&units=metric"
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: { [weak self] (data, response, error) -> Void in
            do{
                let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String:AnyObject]
                
                let id = jsonResponse["id"]!.integerValue
                let name = jsonResponse["name"]!
                let humidity = jsonResponse["main"]!["humidity"]!!.floatValue
                let temperature = jsonResponse["main"]!["temp"]!!.floatValue
                let description = jsonResponse["weather"]!.objectAtIndex(0)["description"]
                
                city = City.init(id: id, name: name as! String, temperature: temperature, humidity: humidity, description: description as! String)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    //        Block returning selected city
                    self?.onCitySelected(city)
                    self?.navigationController?.popViewControllerAnimated(true)
                })
            }
            catch {
                print("json error: \(error)")
            }
        })
        task.resume()
    }
}