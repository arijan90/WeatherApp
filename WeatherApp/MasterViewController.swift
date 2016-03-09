//
//  MasterViewController.swift
//  WeatherApp
//
//  Created by Arijan Ljoki on 5. 03. 16.
//  Copyright © 2016 Arijan Ljoki. All rights reserved.
//

// API-key 546be23921ef651bb1c511c2e6477f79

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var citiesArray = [City]()
    var refreshControlView: UIRefreshControl!
    var userDefaults: NSUserDefaults!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDefaults = NSUserDefaults.standardUserDefaults()
        
        retrieveData()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "selectNewCity:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

        refreshControlView = UIRefreshControl()
        refreshControlView.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControlView.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControlView)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender: AnyObject) {
        if citiesArray.count == 0 {
            refreshControlView.endRefreshing()
            return
        }
        
        var idCities: String = ""
        
        for city in citiesArray {
            idCities += "\(city.id),"
        }
        
        let stringWithoutLastChar = idCities.substringToIndex(idCities.endIndex.predecessor())
        
        GetCityJson.sharedInstance.getJson(stringWithoutLastChar, isGroup: true) { [weak self] (result) -> Void in
            
            let numberOfItems = result["cnt"]!
            let jsonArray = result["list"]!
            
            self?.citiesArray = []
            for var i = 0; i < numberOfItems.integerValue; i++ {
                let city = City.init(json: jsonArray[i] as! NSDictionary)
                self?.citiesArray.append(city)
            }
            
            self?.refreshControlView.endRefreshing()
            self?.tableView.reloadData()
        }
    }

    func selectNewCity(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectCityVC = storyboard.instantiateViewControllerWithIdentifier("SelectCityIdentifier") as! SelectCityViewController

        selectCityVC.onCitySelected = { [weak self] (city) in
            self?.citiesArray.insert(city, atIndex: 0)
            self?.saveData()
            
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self?.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        navigationController?.pushViewController(selectCityVC, animated: true)
    }
    
    // MARK: - Save data to NSUserDefaults
    
    func saveData() {
        let archivedObject = NSKeyedArchiver.archivedDataWithRootObject(citiesArray as NSArray)
        userDefaults.setObject(archivedObject, forKey: "CityArray")
        userDefaults.synchronize()
    }
    
    func retrieveData() {
        if let unarchivedObject = userDefaults.objectForKey("CityArray") as? NSData {
            citiesArray = NSKeyedUnarchiver.unarchiveObjectWithData(unarchivedObject) as! [City]
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = citiesArray[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.selectedCity = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        configureCell(cell, index: indexPath.row)
        
        return cell
    }
    
    // Populate cell with correct data
    private func configureCell(cell: UITableViewCell, index: Int) {
        let object = citiesArray[index]
        cell.textLabel!.text = object.name
        cell.detailTextLabel!.text = "\(Int(object.temperature))°C"
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            citiesArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

}

