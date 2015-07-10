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
    // Referencia al managed object context
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Lista de contactos
    var contactos = [Contacto]()
    
    /// Al instanciarlo hace un fetch inicial.
    init() {
        fetchContacts()
    }
    
    /// Hace un fetch de todos los Contactos en la base de datos.
    /// Los ordena en orden alfabético con respecto al nombre.
    /// Actualiza la lista de contactos.
    func fetchContacts() {
        // Describimos como vamos a ordenar los Contactos.
        let sortDescriptor = NSSortDescriptor(key: "nombre", ascending: true)
        
        // Creamos el fetch request de Contactos.
        let fetchRequest = NSFetchRequest(entityName: "Contacto")
        
        // Seteamos el orden de los Contactos.
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Hacemos el fetch y manejamos los resultados, solo si el fetch funciona.
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Contacto] {
            // Actualizamos la lista de contactos
            contactos = fetchResults
        }
    }
    
    /// Hace un fetch de todos los Contactos en la base de datos que cumplan con contener los strings estipulados en los atributos nombre, apellido y numero, si es que son distintos de "".
    /// Los ordena en orden alfabético con respecto al nombre.
    /// Actualiza la lista de contactos.
    func fetchContactsWithPredicates(nombre:String, apellido:String, numero:String) {
        // Creamos el array de predicados donde iremos agregando filtros de busqueda a medida que lo necesitemos.
        var predicatesArray = [NSPredicate]()
        
        // Revisamos si hay que aplicar el filtro nombre.
        if nombre != "" {
            // Creamos el filtro de busqueda para el atributo nombre.
            let predicateNombre = NSPredicate(format: "nombre CONTAINS %@", nombre)
            
            // Agregamos este filtro de busqueda a nuestro array de filtros.
            predicatesArray.append(predicateNombre)
        }
        
        // Revisamos si hay que aplicar el filtro apellido.
        if apellido != "" {
            // Creamos el filtro de busqueda para el atributo apellido.
            let predicateApellido = NSPredicate(format: "apellido CONTAINS %@", apellido)
            
            // Agregamos este filtro de busqueda a nuestro array de filtros.
            predicatesArray.append(predicateApellido)
        }
        
        // Revisamos si hay que aplicar el filtro numero.
        if numero != "" {
            // Creamos el filtro de busqueda para el atributo numero.
            let predicateNumero = NSPredicate(format: "numero CONTAINS %@", numero)
            
            // Agregamos este filtro de busqueda a nuestro array de filtros.
            predicatesArray.append(predicateNumero)
        }
        
        // Creamos el filtro de busqueda uniendo todos los que hayamos creado.
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicatesArray)
        
        // Describimos como vamos a ordenar los Contactos.
        let sortDescriptor = NSSortDescriptor(key: "nombre", ascending: true)
        
        // Creamos el fetch request de Contactos.
        let fetchRequest = NSFetchRequest(entityName: "Contacto")
        
        // Seteamos el orden de los Contactos.
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Seteamos los filtros de busqueda.
        fetchRequest.predicate = predicate
        
        // Hacemos el fetch y manejamos los resultados, solo si el fetch funciona.
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Contacto] {
            // Actualizamos la lista de contactos
            contactos = fetchResults
        }
    }
    
    /// Creamos y agregamos un nuevo Contacto a la base de datos.
    func agregarNuevoContacto(nombre:String, apellido:String, numero:String) {
        // Creamos el nuevo contacto
        let contacto = Contacto.new(moc!, _nombre: nombre, _apellido: apellido, _numero: numero)
        
        // Guardamos los cambios en nuestra base de datos
        saveDatabase()
    }
    
    /// Borra un contacto de la base de datos en funcion de su index en la lista de contactos
    func borrarContacto(index:Int) {
        // Revisamos que el index no sea mayor a la lista
        if index < contactos.count {
            // Borramos el contacto de nuestra base de datos
            moc?.deleteObject(contactos[index])
        }
        
        // Guardamos los cambios en nuestra base de datos
        saveDatabase()
    }
    
    /// Graba los nuevos cambios en la base de datos.
    /// Si hay un problema imprime en consola el error que ocurrio.
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