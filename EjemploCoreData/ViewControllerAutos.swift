//
//  ViewControllerAutos.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 26-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import CoreData
import UIKit

class ViewControllerAutos: UIViewController, UITextFieldDelegate  {
    var managerAutos = AutosManager()
    var delegateTablaAutos : TablaAutosDelegate!
    var dueno : Contacto!
    
    @IBOutlet weak var TablaAutos: UITableView!
    
    @IBOutlet weak var LabelNombreDueno: UILabel!
    @IBOutlet weak var TextFieldMarca: UITextField!
    @IBOutlet weak var TextFieldModelo: UITextField!
    @IBOutlet weak var TextFieldAno: UITextField!
    @IBOutlet weak var TextFieldKM: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managerAutos.dueno = dueno
        delegateTablaAutos = TablaAutosDelegate()
        delegateTablaAutos.autosManager = managerAutos
        TablaAutos.delegate = delegateTablaAutos
        TablaAutos.dataSource = delegateTablaAutos
        
        TextFieldMarca.delegate = self
        TextFieldModelo.delegate = self
        TextFieldAno.delegate = self
        TextFieldKM.delegate = self
        
        managerAutos.fetchAutos()
        TablaAutos.reloadData()
        
        LabelNombreDueno.text = "Autos de \(dueno.nombre) \(dueno.apellido)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func AgregarNuevoAuto(sender: AnyObject) {
        managerAutos.agregarNuevoAuto(TextFieldMarca.text, modelo: TextFieldModelo.text, ano: TextFieldAno.text, km: TextFieldKM.text)
        managerAutos.fetchAutos()
        TablaAutos.reloadData()
        borrarTextFields()
    }
    
    @IBAction func FetchAutos(sender: AnyObject) {
        if (TextFieldMarca.text != "" || TextFieldModelo.text != "" || TextFieldAno.text != "" || TextFieldKM.text != "") {
            managerAutos.fetchAutosWithPredicates(TextFieldMarca.text, modelo: TextFieldModelo.text, ano: TextFieldAno.text, km: TextFieldKM.text)
        }
        else {
            managerAutos.fetchAutos()
        }
        borrarTextFields()
        TablaAutos.reloadData()
    }
    
    func borrarTextFields() {
        TextFieldMarca.text = ""
        TextFieldModelo.text = ""
        TextFieldAno.text = ""
        TextFieldKM.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == TextFieldKM {
            textField.resignFirstResponder()
        }
        else if textField == TextFieldMarca {
            textField.resignFirstResponder()
            TextFieldModelo.select(self)
        }
        else if textField == TextFieldModelo {
            textField.resignFirstResponder()
            TextFieldAno.select(self)
        }
        else if textField == TextFieldAno {
            textField.resignFirstResponder()
            TextFieldKM.select(self)
        }
        return true
    }
}
