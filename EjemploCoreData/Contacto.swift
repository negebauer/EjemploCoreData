//
//  Contacto.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 22-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData

/// Clase Contacto para manejar las entidades de tipo Contacto de la base de datos.
class Contacto: NSManagedObject {

    // Los atributos del Contacto.
    @NSManaged var apellido: String
    @NSManaged var nombre: String
    @NSManaged var numero: String
    @NSManaged var autos: NSSet

    /// Crea un nuevo Contacto, lo agrega a la base de datos, setea los atributos entregados y retorna dicho Contacto.
    class func new(moc: NSManagedObjectContext, _nombre:String, _apellido:String, _numero:String) -> Contacto {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Contacto", inManagedObjectContext: moc) as! EjemploCoreData.Contacto
        newItem.nombre = _nombre
        newItem.apellido = _apellido
        newItem.numero = _numero
        
        return newItem
    }
    
    /// Asigna un Auto al Contacto agregandolo a su Set de Autos y seteando el atributo dueno del Auto para que corresponda al Contacto.
    func darAuto(auto:Auto) {
        var set = autos as! Set<Auto>
        set.insert(auto)
        auto.asignarDueno(self)
        autos = set
    }
    
    /// Quita un Auto al Contacto eliminandolo de su Set de Autos y setenado el atributo dueno del Auto a nil.
    func quitarAuto(auto:Auto) {
        var set = autos as! Set<Auto>
        if set.contains(auto) {
            set.remove(auto)
            auto.eliminarDueno()
        }
        autos = set
    }
}
