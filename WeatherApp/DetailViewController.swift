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

    func configureView() {
        // Update the user interface for the detail item.
        if let selectedCity = self.selectedCity {
            detailDescriptionLabel.text = selectedCity.name
            temperatureLabel.text = String(selectedCity.temperature)
            humidityLabel.text = String(selectedCity.humidity)
            descriptionLabel.text = String(selectedCity.description)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

