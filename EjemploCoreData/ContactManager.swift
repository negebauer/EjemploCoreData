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

/// El manager de Contactos.
/// Se encarga de todo lo relacionado con el manejo de los objetos Contacto con respecto a la base de datos.
class ContactManager {
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var contactos = [Contacto]()
    
    init() {
        fetchContacts()
    }
    
    /// Hace un fetch de todos los Contactos en la base de datos.
    /// Los ordena en orden alfabético con respecto al nombre.
    /// Actualiza la lista de contactos.
    func fetchContacts() {
        let sortDescriptor = NSSortDescriptor(key: "nombre", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Contacto")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = (try? moc!.executeFetchRequest(fetchRequest)) as? [Contacto] {
            contactos = fetchResults
        }
    }
    
    /// Hace un fetch de todos los Contactos en la base de datos que cumplan con contener los strings estipulados en los atributos nombre, apellido y numero, si es que son distintos de "".
    /// Los ordena en orden alfabético con respecto al nombre.
    /// Actualiza la lista de contactos.
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
        
        if let fetchResults = (try? moc!.executeFetchRequest(fetchRequest)) as? [Contacto] {
            contactos = fetchResults
        }
    }
    
    /// Creamos y agregamos un nuevo Contacto a la base de datos.
    func agregarNuevoContacto(nombre:String, apellido:String, numero:String) {
        _ = Contacto.new(moc!, _nombre: nombre, _apellido: apellido, _numero: numero)
        
        saveDatabase()
    }
    
    /// Borra un contacto de la base de datos en funcion de su index en la lista de contactos
    func borrarContacto(index:Int) {
        if index < contactos.count {
            moc?.deleteObject(contactos[index])
        }
        
        saveDatabase()
    }
    
    /// Graba los nuevos cambios en la base de datos.
    /// Si hay un problema imprime en consola el error que ocurrio.
    func saveDatabase() {
        do {
            try moc!.save()
        } catch {
            
        }
    }
}