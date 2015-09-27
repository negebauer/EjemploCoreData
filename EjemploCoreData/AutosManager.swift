//
//  AutoManager.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 26-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/// El manager de Autos.
/// Se encarga de todo lo relacionado con el manejo de los objetos Autos de un Contacto con respecto a la base de datos.
class AutosManager {
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var autos = [Auto]()
    weak var dueno : Contacto!
    
    init() {
        fetchAutos()
    }
    
    /// Hace un fetch de todos los Autos de un dueno en la base de datos.
    /// Los ordena en orden alfabético con respecto a la marca.
    /// Actualiza la lista de autos.
    func fetchAutos() {
        let sortDescriptor = NSSortDescriptor(key: "marca", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Auto")
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = (try? moc!.executeFetchRequest(fetchRequest)) as? [Auto] {
            // Actualizamos la lista de autos, filtrando los autos que corresponden al dueno que tenemos abierto.
            autos = fetchResults.filter({c in return c.dueno == self.dueno})
        }
    }
    
    /// Hace un fetch de todos los Autos en la base de datos que cumplan con contener los strings estipulados en los atributos marca, modelo y ano, si es que son distintos de "" y que el kilometraje sea igual.
    /// Los ordena en orden alfabético con respecto a la marca.
    /// Actualiza la lista de autos.
    func fetchAutosWithPredicates(marca:String, modelo:String, ano:String, km:String) {
        let kmInt = Int(km)
        var predicatesArray = [NSPredicate]()

        if marca != "" {
            let predicateMarca = NSPredicate(format: "marca CONTAINS %@", marca)
            predicatesArray.append(predicateMarca)
        }
        
        if modelo != "" {
            let predicateModelo = NSPredicate(format: "modelo CONTAINS %@", modelo)
            predicatesArray.append(predicateModelo)
        }
        
        if ano != "" {
            let predicateAno = NSPredicate(format: "ano CONTAINS %@", ano)
            predicatesArray.append(predicateAno)
        }
        
        if kmInt != nil {
            let predicateKM = NSPredicate(format: "kilometraje == %i", kmInt!)
            predicatesArray.append(predicateKM)
        }
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicatesArray)
        let sortDescriptor = NSSortDescriptor(key: "marca", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Auto")
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        
        if let fetchResults = (try? moc!.executeFetchRequest(fetchRequest)) as? [Auto] {
            autos = fetchResults.filter({c in return c.dueno == self.dueno})
        }
    }
    
    /// Creamos y agregamos un nuevo Auto a la base de datos.
    func agregarNuevoAuto(marca:String, modelo:String, ano:String, km:String) {
        let kmInt = Int(km)
        
        if kmInt == nil {
            let auto = Auto.new(moc!, _marca: marca, _modelo: modelo, _ano: ano, _kilometraje: 0)
            dueno.darAuto(auto)
        }
        else {
            let auto = Auto.new(moc!, _marca: marca, _modelo: modelo, _ano: ano, _kilometraje: kmInt!)
            dueno.darAuto(auto)
        }
        
        saveDatabase()
    }
    
    /// Borra un auto de la base de datos en funcion de su index en la lista de autos
    func borrarAuto(index:Int) {
        if index < autos.count {
            moc?.deleteObject(autos[index])
            dueno.quitarAuto(autos[index])
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