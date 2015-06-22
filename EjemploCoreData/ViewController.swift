//
//  ViewController.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 17-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var managerContactos = ContactManager()
    var delegateTablaContactos : TablaContactosDelegate!
    
    @IBOutlet weak var TablaContactos: UITableView!

    @IBOutlet weak var LabelNombre: UITextField!
    @IBOutlet weak var LabelApellido: UITextField!
    @IBOutlet weak var LabelNumero: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegateTablaContactos = TablaContactosDelegate()
        delegateTablaContactos.contactManager = managerContactos
        TablaContactos.delegate = delegateTablaContactos
        TablaContactos.dataSource = delegateTablaContactos
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func AgregarNuevoContacto(sender: AnyObject) {
        managerContactos.agregarNuevoContacto(LabelNombre.text, apellido: LabelApellido.text, numero: LabelNumero.text)
        borrarLabels()
    }
    
    @IBAction func FetchContactos(sender: AnyObject) {
        if (LabelNombre.text != "" || LabelApellido.text != "" || LabelNumero.text != "") {
            managerContactos.fetchContactsWithPredicates(LabelNombre.text, apellido: LabelApellido.text, numero: LabelNumero.text)
        }
        else {
            managerContactos.fetchContacts()
        }
        borrarLabels()
        TablaContactos.reloadData()
    }
    
    func borrarLabels() {
        LabelNombre.text = ""
        LabelApellido.text = ""
        LabelNumero.text = ""
    }
}

