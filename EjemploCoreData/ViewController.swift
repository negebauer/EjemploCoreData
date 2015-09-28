//
//  ViewController.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 17-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit
import CoreData

/** View that handles the display of the contacts, the creation of new contacs,
and the possibility to perfom a `Contact` search giving specific parameters to look for.

- Author: Nicolás Gebauer.
- Date: 17-06-15.
- Copyright: © 2015 Nicolás Gebauer.
- SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
*/
class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ContactsTable: UITableView!

    @IBOutlet weak var TextFieldFirstName: UITextField!
    @IBOutlet weak var TextFieldSurname: UITextField!
    @IBOutlet weak var TextFieldNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - User actions

    /** Adds a new `Contact` to the database using the information of the text fields.
    
    - Author: Nicolás Gebauer.
    - Date: 17-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    @IBAction func addNewContact(sender: AnyObject) {

    }
    
    /** Does a fetch for a specified `Contact` if any text field `text` isn't empty.
    Perfoms a complete `Contact` fetch if there is no text field with any info.
    
    - Author: Nicolás Gebauer.
    - Date: 17-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    @IBAction func fetchContacts(sender: AnyObject) {
        
    }
    
    // MARK: - Internal actions
    
    /** Deletes the content (`text`) of all the text fields in this view.
    
    - Author: Nicolás Gebauer.
    - Date: 17-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func deleteTextFields() {
        TextFieldFirstName.text = ""
        TextFieldSurname.text = ""
        TextFieldNumber.text = ""
    }
    
    /** Defines what happens when the key `Return` is pressed.
    Controls the flow trough text fields.
    
    - Author: Nicolás Gebauer.
    - Date: 17-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == TextFieldNumber {
            textField.resignFirstResponder()
        } else if textField == TextFieldFirstName {
            textField.resignFirstResponder()
            TextFieldSurname.select(self)
        } else if textField == TextFieldSurname {
            textField.resignFirstResponder()
            TextFieldNumber.select(self)
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }

}

