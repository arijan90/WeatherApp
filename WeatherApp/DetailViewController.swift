//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 5. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var selectedCity: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let selectedCity = self.selectedCity {
            detailDescriptionLabel.text = selectedCity.name
            temperatureLabel.text = "\(Int(selectedCity.temperature))°C"
            humidityLabel.text = "\(selectedCity.humidity)%"
            descriptionLabel.text = "\(selectedCity.cityDescription)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

