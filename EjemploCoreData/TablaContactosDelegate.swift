//
//  TablaContactosDelegate.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 21-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit

class TablaContactosDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    weak var contactManager : ContactManager!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("IDCeldaContacto") as! CeldaContacto
        let contacto = contactManager.contactos[indexPath.row]
        c.LabelNumero.text = contacto.numero
        c.LabelNombre.text = contacto.nombre + " " + (contacto.apellido)
        return c
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contactos.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            contactManager.borrarContacto(indexPath.row)
        }
        tableView.setEditing(false, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            
        }
    }
    
}

//referenciaAlControlador?.TablaNombres.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)