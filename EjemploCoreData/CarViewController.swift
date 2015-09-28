//
//  CarViewController.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 26-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import CoreData
import UIKit

/** View that handles the display of the cars, the creation of new cars,
and the possibility to perfom a `Car` search giving specific parameters to look for.

- Author: Nicolás Gebauer.
- Date: 26-06-15.
- Copyright: © 2015 Nicolás Gebauer.
- SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
*/
class CarViewController: UIViewController, UITextFieldDelegate  {
    
    /// The `Car` manager.
    var carManager = CarManager()
    
    /// The delegate that handles the cars table.
    var carsTableDelegate: CarsTableDelegate!
    
    /// The `owner` of the cars being displayed.
    var owner: Contact!
    
    @IBOutlet weak var CarsTable: UITableView!
    
    @IBOutlet weak var LabelOwnerName: UILabel!
    @IBOutlet weak var TextFieldManufacturer: UITextField!
    @IBOutlet weak var TextFieldModel: UITextField!
    @IBOutlet weak var TextFieldYear: UITextField!
    @IBOutlet weak var TextFieldMileage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carManager.owner = owner
        
        carsTableDelegate = CarsTableDelegate()
        carsTableDelegate.refCarManager = carManager
        carsTableDelegate.refCarsTable = CarsTable
        
        CarsTable.delegate = carsTableDelegate
        CarsTable.dataSource = carsTableDelegate
        
        TextFieldManufacturer.delegate = self
        TextFieldModel.delegate = self
        TextFieldYear.delegate = self
        TextFieldMileage.delegate = self
        
        carManager.fetchCars()
        CarsTable.reloadData()
        
        LabelOwnerName.text = "Cars \(owner.firstName) \(owner.surname)"
    }
    
    // MARK: - User actions
    
    /** Adds a new `Car` to the database using the information of the text fields.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    @IBAction func addNewCar(sender: AnyObject) {
        if TextFieldMileage.text != "" && Int(TextFieldMileage.text!) == nil {
            let alertController = UIAlertController(title: "Información incorrecta", message:"Escribe solo un numero en kilometraje, o déjalo vacio para que sea 0 automaticamente", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        carManager.addNewCar(TextFieldManufacturer.text!, model: TextFieldModel.text!, year: TextFieldYear.text!, mileage: TextFieldMileage.text!)
        
        carManager.fetchCars()
        
        CarsTable.reloadData()
        deleteTextFields()
    }
    
    /** Does a fetch for a specified `Car` if any text field `text` isn't empty.
    Perfoms a complete `Car` fetch if there is no text field with any info.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    @IBAction func fetchCars(sender: AnyObject) {
        if (TextFieldManufacturer.text != "" ||
            TextFieldModel.text != "" ||
            TextFieldYear.text != "" ||
            TextFieldMileage.text != "") {

                carManager.fetchCarsWithPredicates(TextFieldManufacturer.text!, model: TextFieldModel.text!, year: TextFieldYear.text!, mileage: TextFieldMileage.text!)
        } else {
            carManager.fetchCars()
        }
        deleteTextFields()
        
        CarsTable.reloadData()
    }
    
    // MARK: - Internal actions
    
    /** Deletes the content (`text`) of all the text fields in this view.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func deleteTextFields() {
        TextFieldManufacturer.text = ""
        TextFieldModel.text = ""
        TextFieldYear.text = ""
        TextFieldMileage.text = ""
    }
    
    /** Defines what happens when the key `Return` is pressed.
    Controls the flow trough text fields.
    
    - Author: Nicolás Gebauer.
    - Date: 26-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == TextFieldMileage {
            textField.resignFirstResponder()
        }
        else if textField == TextFieldManufacturer {
            textField.resignFirstResponder()
            TextFieldModel.select(self)
        }
        else if textField == TextFieldModel {
            textField.resignFirstResponder()
            TextFieldYear.select(self)
        }
        else if textField == TextFieldYear {
            textField.resignFirstResponder()
            TextFieldMileage.select(self)
        }
        return true
    }
}
