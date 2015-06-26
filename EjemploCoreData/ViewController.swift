//
//  ViewController.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 17-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    var managerContactos = ContactManager()
    var delegateTablaContactos : TablaContactosDelegate!
    
    @IBOutlet weak var TablaContactos: UITableView!

    @IBOutlet weak var TextFieldNombre: UITextField!
    @IBOutlet weak var TextFieldApellido: UITextField!
    @IBOutlet weak var TextFieldNumero: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTablaContactos = TablaContactosDelegate()
        delegateTablaContactos.referenciaAlViewController = self
        delegateTablaContactos.contactManager = managerContactos
        TablaContactos.delegate = delegateTablaContactos
        TablaContactos.dataSource = delegateTablaContactos
        
        TextFieldApellido.delegate = self
        TextFieldNombre.delegate = self
        TextFieldNumero.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func AgregarNuevoContacto(sender: AnyObject) {
        managerContactos.agregarNuevoContacto(TextFieldNombre.text, apellido: TextFieldApellido.text, numero: TextFieldNumero.text)
        managerContactos.fetchContacts()
        TablaContactos.reloadData()
        borrarTextFields()
    }
    
    @IBAction func FetchContactos(sender: AnyObject) {
        if (TextFieldNombre.text != "" || TextFieldApellido.text != "" || TextFieldNumero.text != "") {
            managerContactos.fetchContactsWithPredicates(TextFieldNombre.text, apellido: TextFieldApellido.text, numero: TextFieldNumero.text)
        }
        else {
            managerContactos.fetchContacts()
        }
        borrarTextFields()
        TablaContactos.reloadData()
    }
    
    func borrarTextFields() {
        TextFieldNombre.text = ""
        TextFieldApellido.text = ""
        TextFieldNumero.text = ""
    }
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == nil {
            return
        }
        if segue.identifier == "IDMostrarAutosContacto" {
            let vistaAutos = segue.destinationViewController as! ViewControllerAutos
            vistaAutos.dueno = delegateTablaContactos.contactoAMostrarAutos
        }
    }
}

