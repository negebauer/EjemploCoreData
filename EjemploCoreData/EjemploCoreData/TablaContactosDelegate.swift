//
//  TablaContactosDelegate.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 21-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit

/// Delegate de la tabla de contactos.
/// Maneja la visualizacion de los contactos, el acceso a sus autos y la eliminacion de contactos.
class TablaContactosDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    // Referencia al manager de contactos.
    weak var contactManager : ContactManager!
    
    // Si hacemos clic en un contacto, seteamos aqui para saber de donde obtener los Autos.
    var contactoAMostrarAutos : Contacto!
    
    // Referencia al view controller de contactos. La usamos para el segue.
    weak var referenciaAlViewController: ViewController!

    // Referencia a la tabla de contactos.
    weak var referenciaALaTablaContactos : UITableView!
    
    /// Seteamos cada celda de Contacto.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCellWithIdentifier("IDCeldaContacto") as! CeldaContacto
        
        // El contacto cuya informacion mostraremos para un indice dado.
        let contacto = contactManager.contactos[indexPath.row]
        
        // Seteamos la informacion a mostrar.
        c.LabelNumero.text = contacto.numero
        c.LabelNombre.text = contacto.nombre + " " + (contacto.apellido)
        
        // Retornamos la celda a mostrar.
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
        
        // Nos preparamos para mostrar los autos del contacto seleccionado.
        contactoAMostrarAutos = contactManager.contactos[indexPath.row]
        
        // Cambiamos a la vista de los autos de este contacto.
        referenciaAlViewController.performSegueWithIdentifier("IDMostrarAutosContacto", sender: referenciaAlViewController)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            // Le decimos al manager de contactos que elimine este contacto de la base de datos.
            contactManager.borrarContacto(indexPath.row)
            
            // Actualizamos la lista de contactos.
            contactManager.fetchContacts()
            
            // Recargamos la tabla para mostrar la nueva lista de contactos.
            referenciaALaTablaContactos.reloadData()
        }
        tableView.setEditing(false, animated: true)
    }
    
}