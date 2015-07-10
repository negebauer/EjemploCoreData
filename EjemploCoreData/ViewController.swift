//
//  ViewController.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 17-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit
import CoreData

/// Vista de la lista de Contactos junto con los TextFields que le corresponden.
class ViewController: UIViewController, UITextFieldDelegate {
    var managerContactos = ContactManager()
    var delegateTablaContactos : TablaContactosDelegate!
    
    // Referencia al TableView de contactos
    @IBOutlet weak var TablaContactos: UITableView!

    // Los distintos TextField que el usuario va a llenar
    @IBOutlet weak var TextFieldNombre: UITextField!
    @IBOutlet weak var TextFieldApellido: UITextField!
    @IBOutlet weak var TextFieldNumero: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creamos nuestro delegate y le damos las referencias apropiadas
        delegateTablaContactos = TablaContactosDelegate()
        delegateTablaContactos.referenciaAlViewController = self
        delegateTablaContactos.contactManager = managerContactos
        delegateTablaContactos.referenciaALaTablaContactos = TablaContactos
        
        // Conectamos nuestra Tabla con nuestro delegate
        TablaContactos.delegate = delegateTablaContactos
        TablaContactos.dataSource = delegateTablaContactos
        
        // Seteamos el delegate de los TextField para que se pueda pasar de uno a otro apretando Enter
        TextFieldApellido.delegate = self
        TextFieldNombre.delegate = self
        TextFieldNumero.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// Agrega un nuevo contacto a la base de datos con los atributos estipulados en los TextFields
    @IBAction func AgregarNuevoContacto(sender: AnyObject) {
        // Llama al manager de contactos para que agregue un nuevo contacto con los atributos dados
        managerContactos.agregarNuevoContacto(TextFieldNombre.text, apellido: TextFieldApellido.text, numero: TextFieldNumero.text)
        
        // Vuelve a cargar la lista de contactos
        managerContactos.fetchContacts()
        
        // Recarga la tabla para mostrar la nueva lista de contactos
        TablaContactos.reloadData()
        borrarTextFields()
    }
    
    /// Hace un fetch de todos los contactos. Filtra este busqueda si hay atributos en algun TextField
    @IBAction func FetchContactos(sender: AnyObject) {
        // Revisa si hay algun atributo que se tenga que usar para filtrar la busqueda
        if (TextFieldNombre.text != "" || TextFieldApellido.text != "" || TextFieldNumero.text != "") {
            managerContactos.fetchContactsWithPredicates(TextFieldNombre.text, apellido: TextFieldApellido.text, numero: TextFieldNumero.text)
        }
        
        // Busca todos los contactos
        else {
            managerContactos.fetchContacts()
        }
        borrarTextFields()
        
        // Recarga la tabla para mostrar la lista de contactos esperada
        TablaContactos.reloadData()
    }
    
    /// Borra los TextField para que el usuario no tenga que hacerlo
    func borrarTextFields() {
        TextFieldNombre.text = ""
        TextFieldApellido.text = ""
        TextFieldNumero.text = ""
    }
    
    /// Define que hacer cuando se apreta Enter en un TextField. Esto para que el cambio de un TextField al siguiente sea automatico. Si es el ultimo TextField cierra el teclado.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == TextFieldNumero {
            textField.resignFirstResponder()
        }
        else if textField == TextFieldNombre {
            textField.resignFirstResponder()
            TextFieldApellido.select(self)
        }
        else if textField == TextFieldApellido {
            textField.resignFirstResponder()
            TextFieldNumero.select(self)
        }
        return true
    }
    
    /// Prepara el segue a una nueva vista. Permite personalizarla antes de cargarla.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nil {
            return
        }
        if segue.identifier == "IDMostrarAutosContacto" {
            // Prepara la nueva vista
            let vistaAutos = segue.destinationViewController as! ViewControllerAutos
            
            // Obtiene el dueño del auto para poder obtener informacion de sus autos
            vistaAutos.dueno = delegateTablaContactos.contactoAMostrarAutos
        }
    }
}

