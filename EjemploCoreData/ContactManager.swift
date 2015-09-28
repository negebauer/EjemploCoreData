//
//  ContactManager.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 21-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/** The `Contact` manager.
Handles everything related to managing the contacts of the database.

- Author: Nicolás Gebauer.
- Date: 21-06-15.
- Copyright: © 2015 Nicolás Gebauer.
- SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
*/
class ContactManager {
    
    /// The managed object context of the database.
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    /// An array containing all contacts.
    var contacts = [Contact]()
    
    init() {
        fetchContacts()
    }
    
    /** Makes a fetch of all the cars, sorts them alphabetically acording to the `firstName`.
    Then updates `contacts` with all of them.
    
    - Author: Nicolás Gebauer.
    - Date: 21-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func fetchContacts() {
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Contact")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = (try? moc!.executeFetchRequest(fetchRequest)) as? [Contact] {
            contacts = fetchResults
        }
    }
    
    /// Hace un fetch de todos los Contactos en la base de datos que cumplan con contener los strings estipulados en los atributos nombre, apellido y numero, si es que son distintos de "".
    /// Los ordena en orden alfabético con respecto al nombre.
    /// Actualiza la lista de contactos.
    
    /** Makes a fetch of all the contacts that comply with the given paramaters, sorts them alphabetically acording to the `firstName`.
    Then updates `contacts` with all of them.
    - Parameter firstName: The first name of the `Contact`.
    - Parameter surname: The surname of the `Contact`.
    - Parameter number: The phone number of the `Contact`.
    
    - Author: Nicolás Gebauer.
    - Date: 21-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func fetchContactsWithPredicates(firstName:String, surname:String, number:String) {
        var predicatesArray = [NSPredicate]()
        
        if firstName != "" {
            let predicateFirstName = NSPredicate(format: "firstName CONTAINS %@", firstName)
            predicatesArray.append(predicateFirstName)
        }
        
        if surname != "" {
            let predicateSurname = NSPredicate(format: "surname CONTAINS %@", surname)
            predicatesArray.append(predicateSurname)
        }
        
        if number != "" {
            let predicateNumber = NSPredicate(format: "number CONTAINS %@", number)
            predicatesArray.append(predicateNumber)
        }
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicatesArray)
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Contact")
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        if let fetchResults = (try? moc!.executeFetchRequest(fetchRequest)) as? [Contact] {
            contacts = fetchResults
        }
    }
    
    /** Creates a new `Contact` and saves it in the database.
    - Parameter firstName: The first name of the `Contact`.
    - Parameter surname: The surname of the `Contact`.
    - Parameter number: The phone number of the `Contact`.
    
    - Author: Nicolás Gebauer.
    - Date: 21-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func addNewContact(firstName: String, surname: String, number: String) {
        _ = Contact.new(moc!, firstName: firstName, surname: surname, number: number)
        
        saveDatabase()
    }
    
    /// Borra un contacto de la base de datos en funcion de su index en la lista de contactos
    
    /** Deletes a `Contact` from the database using an `index`.
    Doesn't do anything if the `index` is bigger than the array.
    - Parameter index: The index of the `Contact` to be deleted in the array `contacts`.
    
    - Author: Nicolás Gebauer.
    - Date: 21-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func deleteContact(index:Int) {
        if index < contacts.count {
            moc?.deleteObject(contacts[index])
        }
        
        saveDatabase()
    }
    
    /** Saves changes in the database.
    
    - Author: Nicolás Gebauer.
    - Date: 21-06-15.
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