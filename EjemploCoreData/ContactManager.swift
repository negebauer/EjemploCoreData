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
        let sortDescriptor = NSSortDescriptor(key: "nombre", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Contacto")
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Contacto] {
            contactos = fetchResults
        }
    }
    
    func fetchContactsWithPredicates(nombre:String, apellido:String, numero:String) {
        var predicatesArray = [NSPredicate]()
        if nombre != "" {
            let predicateNombre = NSPredicate(format: "nombre CONTAINS %@", nombre)
            predicatesArray.append(predicateNombre)
        }
        if apellido != "" {
            let predicateApellido = NSPredicate(format: "apellido CONTAINS %@", apellido)
            predicatesArray.append(predicateApellido)
        }
        if numero != "" {
            let predicateNumero = NSPredicate(format: "numero CONTAINS %@", numero)
            predicatesArray.append(predicateNumero)
        }
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicatesArray)
        let sortDescriptor = NSSortDescriptor(key: "nombre", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Contacto")
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Contacto] {
            contactos = fetchResults
        }
    }
    
    func agregarNuevoContacto(nombre:String, apellido:String, numero:String) {
        let contacto = Contacto.new(moc!, _nombre: nombre, _apellido: apellido, _numero: numero)
        saveDatabase()
    }
    
    func borrarContacto(index:Int) {
        if index < contactos.count {
            moc?.deleteObject(contactos[index])
        }
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