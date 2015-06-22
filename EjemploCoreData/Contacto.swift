//
//  Contacto.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 21-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData

class Contacto: NSManagedObject {

    @NSManaged var nombre: String
    @NSManaged var apellido: String
    @NSManaged var numero: String

    class func new(moc: NSManagedObjectContext, _nombre:String, _apellido:String, _numero:String) -> Contacto {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Contacto", inManagedObjectContext: moc) as! EjemploCoreData.Contacto
        newItem.nombre = _nombre
        newItem.apellido = _apellido
        newItem.numero = _numero
        
        return newItem
    }
}
