//
//  CarsTableDelegate.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 26-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit

/** Delegate and data source of the `Car` table.
Manages the display and deletion comand of all the cars.

- Author: Nicolás Gebauer.
- Date: 26-06-15.
- Copyright: © 2015 Nicolás Gebauer.
- SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
*/
class CarsTableDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {

    /// Reference to the `Car` manager.
    weak var refCarManager : CarManager!
    
    /// Reference to the table view were the `cars` are shown.
    weak var refCarsTable : UITableView!
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    // MARK: - UITableViewDataSource methods
    
    /** Sets every cell to display the information of a `Car`.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let carCell = tableView.dequeueReusableCellWithIdentifier(IDCarCell) as! CarCell
        
        let car = refCarManager.cars[indexPath.row]
        carCell.LabelName.text = "\(car.manufacturer) \(car.model) \(car.year)"
        carCell.LabelMileage.text = "\(car.mileage.stringValue) km"
        
        return carCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refCarManager.cars.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /** Deletes a `Car` when a user chooses `delete` while editing a `carCell`.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            refCarManager.deleteCar(indexPath.row)
            refCarManager.fetchCars()
            refCarsTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        tableView.setEditing(false, animated: true)
    }
    
}