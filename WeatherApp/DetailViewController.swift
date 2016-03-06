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


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                
                let londonWeatherUrl = "http://api.openweathermap.org/data/2.5/weather?q=London"// + detail.description
                
                let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: londonWeatherUrl)!, completionHandler: { (data, response, error) -> Void in
                    do{
                        print(data)
                        //                let str = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
                        //                print(str)
                    }
                    catch {
                        print("json error: \(error)")
                    }
                })
                task.resume()
            }
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

