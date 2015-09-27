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

    weak var autosManager : AutosManager!
    weak var referenciaALaTablaAutos : UITableView!
    
    /// Seteamos cada celda de Auto.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("IDCeldaAuto") as! CeldaAuto
        
        let auto = autosManager.autos[indexPath.row]
        
        c.LabelNombre.text = "\(auto.marca) \(auto.modelo) \(auto.ano)"
        c.LabelKM.text = "\(auto.kilometraje.stringValue) km"
        
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
            autosManager.borrarAuto(indexPath.row)
            autosManager.fetchAutos()
            referenciaALaTablaAutos.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        tableView.setEditing(false, animated: true)
    }
    
}