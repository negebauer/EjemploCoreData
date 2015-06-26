//
//  Contacto.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 22-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData

class Contacto: NSManagedObject {

    @NSManaged var apellido: String
    @NSManaged var nombre: String
    @NSManaged var numero: String
    @NSManaged var autos: NSSet

    class func new(moc: NSManagedObjectContext, _nombre:String, _apellido:String, _numero:String) -> Contacto {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Contacto", inManagedObjectContext: moc) as! EjemploCoreData.Contacto
        newItem.nombre = _nombre
        newItem.apellido = _apellido
        newItem.numero = _numero
        
        return newItem
    }
    
    func darAuto(auto:Auto) {
        var set = autos as! Set<Auto>
        set.insert(auto)
        auto.asignarDueno(self)
        autos = set
    }
    
    func quitarAuto(auto:Auto) {
        var set = autos as! Set<Auto>
        if set.contains(auto) {
            set.remove(auto)
            auto.eliminarDueno()
        }
        autos = set
    }
}
