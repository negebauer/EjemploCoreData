//
//  ViewController.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 17-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var delegateTablaContactos : TablaContactosDelegate!
    @IBOutlet weak var TablaContactos: UITableView!

    @IBOutlet weak var LabelNombre: UITextField!
    @IBOutlet weak var LabelApellido: UITextField!
    @IBOutlet weak var LabelNumero: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func AgregarNuevoContacto(sender: AnyObject) {
    
    }
    
    @IBAction func FetchContactos(sender: AnyObject) {
    
    }

}

