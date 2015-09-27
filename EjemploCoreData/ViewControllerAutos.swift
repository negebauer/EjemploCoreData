//
//  ViewControllerAutos.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 26-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import CoreData
import UIKit

/// Vista de la lista de Autos junto con los TextFields que le corresponden.
class ViewControllerAutos: UIViewController, UITextFieldDelegate  {
    var managerAutos = AutosManager()
    var delegateTablaAutos : TablaAutosDelegate!
    var dueno : Contacto!
    
    // Referencia al TableView de autos
    @IBOutlet weak var TablaAutos: UITableView!
    
    // Los distintos TextField que el usuario va a llenar
    @IBOutlet weak var LabelNombreDueno: UILabel!
    @IBOutlet weak var TextFieldMarca: UITextField!
    @IBOutlet weak var TextFieldModelo: UITextField!
    @IBOutlet weak var TextFieldAno: UITextField!
    @IBOutlet weak var TextFieldKM: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managerAutos.dueno = dueno
        
        // Creamos nuestro delegate y le damos las referencias apropiadas
        delegateTablaAutos = TablaAutosDelegate()
        delegateTablaAutos.autosManager = managerAutos
        delegateTablaAutos.referenciaALaTablaAutos = TablaAutos
        
        // Conectamos nuestra Tabla con nuestro delegate
        TablaAutos.delegate = delegateTablaAutos
        TablaAutos.dataSource = delegateTablaAutos
        
        // Seteamos el delegate de los TextField para que se pueda pasar de uno a otro apretando Enter
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
    
    /// Agrega un nuevo auto a la base de datos con los atributos estipulados en los TextFields.
    @IBAction func AgregarNuevoAuto(sender: AnyObject) {
        // Verifica que no haya nada incorrecto escrito en el atributo kilometraje.
        // Termina la funcion y muestra si este es el caso.
        if TextFieldKM.text != "" && Int(TextFieldKM.text!) == nil {
            let alertController = UIAlertController(title: "Información incorrecta", message:"Escribe solo un numero en kilometraje, o déjalo vacio para que sea 0 automaticamente", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        // Llama al manager de autos para que agregue un nuevo auto con los atributos dados
        managerAutos.agregarNuevoAuto(TextFieldMarca.text!, modelo: TextFieldModelo.text!, ano: TextFieldAno.text!, km: TextFieldKM.text!)
        
        // Vuelve a cargar la lista de autos
        managerAutos.fetchAutos()
        
        // Recarga la tabla para mostrar la nueva lista de autos
        TablaAutos.reloadData()
        borrarTextFields()
    }
    
    /// Hace un fetch de todos los autos. Filtra este busqueda si hay atributos en algun TextField.
    @IBAction func FetchAutos(sender: AnyObject) {
        // Revisa si hay algun atributo que se tenga que usar para filtrar la busqueda.
        if (TextFieldMarca.text != "" || TextFieldModelo.text != "" || TextFieldAno.text != "" || TextFieldKM.text != "") {
            managerAutos.fetchAutosWithPredicates(TextFieldMarca.text!, modelo: TextFieldModelo.text!, ano: TextFieldAno.text!, km: TextFieldKM.text!)
        }
        // Busca todos los contactos.
        else {
            managerAutos.fetchAutos()
        }
        borrarTextFields()
        
        // Recarga la tabla para mostrar la lista de contactos esperada.
        TablaAutos.reloadData()
    }
    
    /// Borra los TextField para que el usuario no tenga que hacerlo.
    func borrarTextFields() {
        TextFieldMarca.text = ""
        TextFieldModelo.text = ""
        TextFieldAno.text = ""
        TextFieldKM.text = ""
    }
    
    /// Define que hacer cuando se apreta Enter en un TextField. Esto para que el cambio de un TextField al siguiente sea automatico. Si es el ultimo TextField cierra el teclado.
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
