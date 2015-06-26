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

class AutosManager {
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var autos = [Auto]()
    weak var dueno : Contacto!
    
    init() {
        fetchAutos()
    }
    
    func fetchAutos() {
        let sortDescriptor = NSSortDescriptor(key: "marca", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Auto")
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Auto] {
            autos = fetchResults.filter({c in return c.dueno == self.dueno})
        }
    }
    
    func fetchAutosWithPredicates(marca:String, modelo:String, ano:String, km:String) {
        let kmInt = km.toInt()
        var predicatesArray = [NSPredicate]()
        if marca != "" {
            let predicateMarca = NSPredicate(format: "nombre CONTAINS %@", marca)
            predicatesArray.append(predicateMarca)
        }
        if modelo != "" {
            let predicateModelo = NSPredicate(format: "apellido CONTAINS %@", modelo)
            predicatesArray.append(predicateModelo)
        }
        if ano != "" {
            let predicateAno = NSPredicate(format: "numero CONTAINS %@", ano)
            predicatesArray.append(predicateAno)
        }
        if kmInt != nil {
            let predicateKM = NSPredicate(format: "numero == %i", kmInt!)
            predicatesArray.append(predicateKM)
        }
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicatesArray)
        let sortDescriptor = NSSortDescriptor(key: "marca", ascending: true)
        let fetchRequest = NSFetchRequest(entityName: "Auto")
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Auto] {
            autos = fetchResults.filter({c in return c.dueno == self.dueno})
        }
    }
    
    func agregarNuevoAuto(marca:String, modelo:String, ano:String, km:String) {
        let kmInt = km.toInt()
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
    
    func borrarAuto(index:Int) {
        if index < autos.count {
            moc?.deleteObject(autos[index])
            dueno.quitarAuto(autos[index])
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