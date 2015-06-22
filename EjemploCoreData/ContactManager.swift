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

class ContactManager {
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var contactos = [Contacto]()
    
    init() {
        fetchContacts()
    }
    
    func fetchContacts() {
        let fetchRequest = NSFetchRequest(entityName: "Contacto")
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Contacto] {
            contactos = fetchResults
        }
    }
    
    func agregarNuevoContacto(nombre:String, apellido:String, numero:String) {
        let contacto = Contacto.new(moc!, _nombre: nombre, _apellido: apellido, _numero: numero)
        saveDatabase()
    }
    
    func saveDatabase() {
        var error : NSError?
        if(moc!.save(&error) ) {
            if let err = error?.localizedDescription {
                NSLog("Error grabando: ")
                NSLog(error!.localizedDescription as String)
            }
        }
    }
}