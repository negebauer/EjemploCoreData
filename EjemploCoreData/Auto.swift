//
//  Auto.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 22-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData

/// Clase Auto para manejar las entidades de tipo Auto de la base de datos.
class Auto: NSManagedObject {

    // Los atributos del Auto.
    @NSManaged var marca: String
    @NSManaged var modelo: String
    @NSManaged var ano: String
    @NSManaged var kilometraje: NSNumber
    @NSManaged var dueno: Contacto?
    @NSManaged var patenteString:String

    /// Crea un nuevo Auto, lo agrega a la base de datos, setea los atributos entregados y retorna dicho Auto.
    class func new(moc: NSManagedObjectContext, _marca:String, _modelo:String, _ano:String, _kilometraje:Int) -> Auto {
        let newAuto = NSEntityDescription.insertNewObjectForEntityForName("Auto", inManagedObjectContext: moc) as! EjemploCoreData.Auto
        
        newAuto.marca = _marca
        newAuto.modelo = _modelo
        newAuto.ano = _ano
        newAuto.kilometraje = _kilometraje
        
        return newAuto
    }
    
    /// Elimina el dueno de este Auto, nulificandolo.
    func eliminarDueno() {
        dueno = nil
    }
    
    /// Asigna el dueno contacto a este Auto.
    func asignarDueno(contacto:Contacto) {
        dueno = contacto
    }
    
    /// Permite acceder a la patente de este Auto y/o modificarla.
    var patente: String {
        get { return patenteString }
        set { patenteString = newValue }
    }
}
