//
//  Contacto.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 22-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData

/** Class that represents and manages `Contact` object that is saved in the database.
- Parameter firstName: The first name of the `Contact`.
- Parameter surname: The surname of the `Contact`.
- Parameter number: The phone number of the `Contact`.
- Parameter cars: The cars that the `Contact` owns.

- Author: Nicolás Gebauer.
- Date: 22-06-15.
- Copyright: © 2015 Nicolás Gebauer.
- SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
*/
class Contact: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var surname: String
    @NSManaged var number: String
    @NSManaged var cars: NSSet

    /** Creates a new `Contact` in the database and returns it.
    - Parameter firstName: The first name of the `Contact`.
    - Parameter surname: The surname of the `Contact`.
    - Parameter number: The phone number of the `Contact`.
    - Parameter cars: The cars that the `Contact` owns.
    - Returns: `Contact`
    
    - Author: Nicolás Gebauer.
    - Date: 22-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    class func new(moc: NSManagedObjectContext, firstName:String, surname:String, number:String) -> Contact {
        let newContact = NSEntityDescription.insertNewObjectForEntityForName("Contact",
            inManagedObjectContext: moc) as! EjemploCoreData.Contact
        
        newContact.firstName = firstName
        newContact.surname = surname
        newContact.number = number
        
        return newContact
    }
    
    /** Assigns a `Car` to this `Contact` owned cars.
    - Parameter car: The `Car` to be given to this `Contact`.
    
    - Author: Nicolás Gebauer.
    - Date: 22-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func giveCar(car:Car) {
        var set = cars as! Set<Car>
        set.insert(car)
        car.assignOwner(self)
        cars = set
    }
    
    /** Removes a `Car` from this `Contact` owned cars, only if it exists.
    - Parameter car: The `Car` to be taken from to this `Contact`.
    
    - Author: Nicolás Gebauer.
    - Date: 22-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func takeCar(car:Car) {
        var set = cars as! Set<Car>
        if set.contains(car) {
            set.remove(car)
            car.deleteOwner()
        }
        cars = set
    }
}
