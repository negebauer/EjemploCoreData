//
//  TablaAutosDelegate.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 26-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit

/// Delegate de la tabla de autos.
/// Maneja la visualizacion de los autos y la eliminacion de estos.
class TablaAutosDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    // Referencia al manager de autos.
    weak var autosManager : AutosManager!
    
    // Referencia a la tabla de autos.
    weak var referenciaALaTablaAutos : UITableView!
    
    /// Seteamos cada celda de Auto.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("IDCeldaAuto") as! CeldaAuto
        
        // El auto cuya informacion mostraremos para un indice dado.
        let auto = autosManager.autos[indexPath.row]
        
        // Seteamos la informacion a mostrar.
        c.LabelNombre.text = "\(auto.marca) \(auto.modelo) \(auto.ano)"
        c.LabelKM.text = "\(auto.kilometraje.stringValue) km"
        
        // Retornamos la celda a mostrar.
        return c
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autosManager.autos.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            // Le decimos al manager de autos que elimine este contacto de la base de datos.
            autosManager.borrarAuto(indexPath.row)
            
            // Actualizamos la lista de autos.
            autosManager.fetchAutos()
            
            // Recargamos la tabla para mostrar la nueva lista de autos.
            referenciaALaTablaAutos.reloadData()
        }
        tableView.setEditing(false, animated: true)
    }
    
}