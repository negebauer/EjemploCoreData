//
//  CarManager.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 26-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/** The `Car` manager.
Handles everything related to managing the cars of the database.

- Author: Nicolás Gebauer.
- Date: 26-06-15.
- Copyright: © 2015 Nicolás Gebauer.
- SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
*/
class CarManager {
    
    /// The managed object context of the database.
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    /// An array containing all cars.
    var cars = [Car]()
    /// The owners of the cars in `cars`.
    weak var owner: Contact!
    
    init() {
        fetchCars()
    }
    
    /** Makes a fetch of all the cars, sorts them alphabetically acording to the manufacturer.
    Then updates `cars` with only those that belong to the `owner`.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func fetchCars() {
        let sortDescriptor = NSSortDescriptor(key: "manufacturer", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Car")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = (try? moc!.executeFetchRequest(fetchRequest)) as? [Car] {
            cars = fetchResults.filter({car in return car.owner == self.owner})
        }
    }

    /** Makes a fetch of all the cars that comply with the given paramaters, sorts them alphabetically acording to the manufacturer.
    Then updates `cars` with only those that belong to the `owner`.
    - Parameter manufacturer: The manufacterer of the `Car`.
    - Parameter model: The model of the `Car`.
    - Parameter year: The year the `Car` was made.
    - Parameter mileage: The amount of kilometers that the `Car` has travelled.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func fetchCarsWithPredicates(manufacturer: String, model: String, year: String, mileage: String) {
        let kmInt = Int(mileage)
        var predicatesArray = [NSPredicate]()

        if manufacturer != "" {
            let predicateManufacturer = NSPredicate(format: "manufacturer CONTAINS %@", manufacturer)
            predicatesArray.append(predicateManufacturer)
        }
        
        if model != "" {
            let predicateModel = NSPredicate(format: "model CONTAINS %@", model)
            predicatesArray.append(predicateModel)
        }
        
        if year != "" {
            let predicateYear = NSPredicate(format: "year CONTAINS %@", year)
            predicatesArray.append(predicateYear)
        }
        
        if kmInt != nil {
            let predicateKM = NSPredicate(format: "mileage == %i", kmInt!)
            predicatesArray.append(predicateKM)
        }
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicatesArray)
        let sortDescriptor = NSSortDescriptor(key: "manufacturer", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Car")
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        if let fetchResults = (try? moc!.executeFetchRequest(fetchRequest)) as? [Car] {
            cars = fetchResults.filter({car in return car.owner == self.owner})
        }
    }
    
    /** Creates a new `Car` and saves it in the database.
    - Parameter manufacturer: The manufacterer of the `Car`.
    - Parameter model: The model of the `Car`.
    - Parameter year: The year the `Car` was made.
    - Parameter mileage: The amount of kilometers that the `Car` has travelled.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func addNewCar(manufacturer: String, model: String, year: String, mileage: String) {
        let kmInt = Int(mileage)
        
        if kmInt == nil {
            let car = Car.new(moc!, manufacturer: manufacturer, model: model, year: year, mileage: 0)
            owner.giveCar(car)
        } else {
            let car = Car.new(moc!, manufacturer: manufacturer, model: model, year: year, mileage: kmInt!)
            owner.giveCar(car)
        }
        
        saveDatabase()
    }
    
    /** Deletes a `Car` from the database using an `index`.
    Doesn't do anything if the `index` is bigger than the array.
    - Parameter index: The index of the `Car` to be deleted in the array `cars`.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func deleteCar(index:Int) {
        if index < cars.count {
            moc?.deleteObject(cars[index])
            owner.takeCar(cars[index])
        }
        saveDatabase()
    }
    
    /** Saves changes in the database.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func saveDatabase() {
        do {
            try moc!.save()
        } catch {
            
        }
    }
}