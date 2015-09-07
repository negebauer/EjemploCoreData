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
    // Referencia al managed object context
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // Lista de autos
    var autos = [Auto]()
    
    // Referencia al dueno de los Autos que se estan manejando.
    weak var dueno : Contacto!
    
    /// Al instanciarlo hace un fetch inicial.
    init() {
        fetchAutos()
    }
    
    /// Hace un fetch de todos los Autos de un dueno en la base de datos.
    /// Los ordena en orden alfabético con respecto a la marca.
    /// Actualiza la lista de autos.
    func fetchAutos() {
         // Describimos como vamos a ordenar los Autos.
        let sortDescriptor = NSSortDescriptor(key: "marca", ascending: true)
        
        // Creamos el fetch request de Autos.
        let fetchRequest = NSFetchRequest(entityName: "Auto")
        
        // Seteamos el orden de los Autos.
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Hacemos el fetch y manejamos los resultados, solo si el fetch funciona.
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Auto] {
            // Actualizamos la lista de autos, filtrando los autos que corresponden al dueno que tenemos abierto.
            autos = fetchResults.filter({c in return c.dueno == self.dueno})
        }
    }
    
    /// Hace un fetch de todos los Autos en la base de datos que cumplan con contener los strings estipulados en los atributos marca, modelo y ano, si es que son distintos de "" y que el kilometraje sea igual.
    /// Los ordena en orden alfabético con respecto a la marca.
    /// Actualiza la lista de autos.
    func fetchAutosWithPredicates(marca:String, modelo:String, ano:String, km:String) {
        // Si filtraremos kilometraje, aqui obtenemos el Int a revisar.
        let kmInt = km.toInt()
        
        // Creamos el array de predicados donde iremos agregando filtros de busqueda a medida que lo necesitemos.
        var predicatesArray = [NSPredicate]()
        
        // Revisamos si hay que aplicar el filtro marca.
        if marca != "" {
            // Creamos el filtro de busqueda para el atributo marca.
            let predicateMarca = NSPredicate(format: "marca CONTAINS %@", marca)
            
            // Agregamos este filtro de busqueda a nuestro array de filtros.
            predicatesArray.append(predicateMarca)
        }
        
        // Revisamos si hay que aplicar el filtro modelo.
        if modelo != "" {
            // Creamos el filtro de busqueda para el atributo modelo.
            let predicateModelo = NSPredicate(format: "modelo CONTAINS %@", modelo)
            
            // Agregamos este filtro de busqueda a nuestro array de filtros.
            predicatesArray.append(predicateModelo)
        }
        
        // Revisamos si hay que aplicar el filtro ano.
        if ano != "" {
            // Creamos el filtro de busqueda para el atributo ano.
            let predicateAno = NSPredicate(format: "ano CONTAINS %@", ano)
            
            // Agregamos este filtro de busqueda a nuestro array de filtros.
            predicatesArray.append(predicateAno)
        }
        
        // Revisamos si hay que aplicar el filtro kilometraje.
        if kmInt != nil {
            // Creamos el filtro de busqueda para el atributo kilometraje.
            let predicateKM = NSPredicate(format: "kilometraje == %i", kmInt!)
            
            // Agregamos este filtro de busqueda a nuestro array de filtros.
            predicatesArray.append(predicateKM)
        }
        
        // Creamos el filtro de busqueda uniendo todos los que hayamos creado.
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: predicatesArray)
        
        // Describimos como vamos a ordenar los Autos.
        let sortDescriptor = NSSortDescriptor(key: "marca", ascending: true)
        
        // Creamos el fetch request de Autos.
        let fetchRequest = NSFetchRequest(entityName: "Auto")
        
        // Seteamos el orden de los Autos.
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Seteamos los filtros de busqueda.
        fetchRequest.predicate = predicate
        
        // Hacemos el fetch y manejamos los resultados, solo si el fetch funciona.
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [Auto] {
            // Actualizamos la lista de autos, filtrando los autos que corresponden al dueno que tenemos abierto.
            autos = fetchResults.filter({c in return c.dueno == self.dueno})
        }
    }
    
    /// Creamos y agregamos un nuevo Auto a la base de datos.
    func agregarNuevoAuto(marca:String, modelo:String, ano:String, km:String) {
        // Revisamos si hay un kilometraje a fijar
        let kmInt = km.toInt()
        
        if kmInt == nil {
            // Si no hay kilometraje, creamos un nuevo Auto con kilometraje 0.
            let auto = Auto.new(moc!, _marca: marca, _modelo: modelo, _ano: ano, _kilometraje: 0)
            
            // Le asignamos al dueno este Auto.
            dueno.darAuto(auto)
        }
        else {
            // Creamos un Auto con el kilometraje especificado.
            let auto = Auto.new(moc!, _marca: marca, _modelo: modelo, _ano: ano, _kilometraje: kmInt!)
            
            // Le asignamos al dueno este Auto.
            dueno.darAuto(auto)
        }
        
        // Guardamos los cambios en nuestra base de datos
        saveDatabase()
    }
    
    /// Borra un auto de la base de datos en funcion de su index en la lista de autos
    func borrarAuto(index:Int) {
        // Revisamos que el index no sea mayor a la lista
        if index < autos.count {
            // Borramos el auto de nuestra base de datos
            moc?.deleteObject(autos[index])
            
            // Le quitamos el auto al dueno ya que lo eliminamos.
            dueno.quitarAuto(autos[index])
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