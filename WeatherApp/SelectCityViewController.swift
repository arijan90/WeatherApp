//
//  SelectCityViewController.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 5. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import UIKit

class SelectCityViewController: UIViewController {
    
    @IBOutlet weak var selectCityTextField: UITextField!
    
    var onCitySelected : ((City) -> ())!
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveNewCity:")
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.enabled = false
        
        selectCityTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func textFieldDidChange(textField: UITextField) {
        // Check each input and if its not space or new line then enable Save button
        let inputText = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        navigationItem.rightBarButtonItem?.enabled = inputText.characters.count > 0 ? true : false
    }
    
    func saveNewCity(sender: AnyObject) {
        let cityName = selectCityTextField.text!
        
        GetCityJson.sharedInstance.getJson(cityName, isGroup: false) { [weak self] (result) -> Void in
            
            // Parse JSON result to City
            let city = City.init(json: result)
            
            // Block returning selected city
            self?.onCitySelected(city)
            self?.navigationController?.popViewControllerAnimated(true)
        }
    }
}