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
    
    var onCitySelected : ((String) -> ())!
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveNewCity:")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func saveNewCity(sender: AnyObject) {
        onCitySelected("Novo mesto")
        
        navigationController?.popViewControllerAnimated(true)
    }
}