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
    
    @IBOutlet weak var warningLabel: UILabel!
    var onCitySelected : ((City) -> ())!
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveNewCity:")
        navigationItem.rightBarButtonItem = addButton
        navigationItem.rightBarButtonItem?.enabled = false
        
        navigationItem.title = "Add new city"
        warningLabel.text = ""
        
        selectCityTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        selectCityTextField.becomeFirstResponder()
    }
    
    func textFieldDidChange(textField: UITextField) {
        // Check each input and if its not space or new line then enable Save button
        let inputText = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        navigationItem.rightBarButtonItem?.enabled = inputText.characters.count > 0 ? true : false
        warningLabel.text = ""
    }
    
    func saveNewCity(sender: AnyObject) {
        let cityName = selectCityTextField.text!
        
        GetCityJson.sharedInstance.getCity(cityName, isGroup: false) { [weak self] (result) -> Void in
            
            self?.warningLabel.text = ""
            
            // Check if response is 404, then show error message
            if let code = result.objectForKey("cod") {
                if code as? String == "404" {
                    self?.warningLabel.text = result.objectForKey("message") as? String
                    return
                }
            }
            
            // Parse JSON result to City
            let city = City.init(json: result)
            
            // Block returning selected city
            self?.onCitySelected(city)
            self?.navigationController?.popViewControllerAnimated(true)
        }
    }
}