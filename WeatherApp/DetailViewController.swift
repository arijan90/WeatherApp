//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 5. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let apiKey = "546be23921ef651bb1c511c2e6477f79"

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
                
//                let url = "http://api.openweathermap.org/data/2.5/weather?q=\(selectedCity.name)&APPID=\(apiKey)"
//                
//                let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: { (data, response, error) -> Void in
//                    do{
//                        let str = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
//                        print(str)
//                    }
//                    catch {
//                        print("json error: \(error)")
//                    }
//                })
//                task.resume()
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

