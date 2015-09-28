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
>>>>>>> master

- Author: Nicolás Gebauer.
- Date: 17-06-15.
- Copyright: © 2015 Nicolás Gebauer.
- SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
*/
class ViewController: UIViewController, UITextFieldDelegate {
    
    /// The `Contact` manager.
    var contactsManager = ContactManager()
    
    /// The delegate that handles the contacts table.
    var contactsTableDelegate : ContactsTableDelegate!
    
    @IBOutlet weak var ContactsTable: UITableView!

    @IBOutlet weak var TextFieldFirstName: UITextField!
    @IBOutlet weak var TextFieldSurname: UITextField!
    @IBOutlet weak var TextFieldNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTableDelegate = ContactsTableDelegate()
        contactsTableDelegate.refViewController = self
        contactsTableDelegate.refContactManager = contactsManager
        contactsTableDelegate.refContactsTable = ContactsTable
        
        ContactsTable.delegate = contactsTableDelegate
        ContactsTable.dataSource = contactsTableDelegate
        
        TextFieldFirstName.delegate = self
        TextFieldSurname.delegate = self
        TextFieldNumber.delegate = self
    }
    
    // MARK: - User actions

    /** Adds a new `Contact` to the database using the information of the text fields.
    
    - Author: Nicolás Gebauer.
    - Date: 17-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    @IBAction func addNewContact(sender: AnyObject) {
        contactsManager.addNewContact(TextFieldFirstName.text!, surname: TextFieldSurname.text!, number: TextFieldNumber.text!)
        
        contactsManager.fetchContacts()
        
        ContactsTable.reloadData()
        deleteTextFields()
    }
    
    /** Does a fetch for a specified `Contact` if any text field `text` isn't empty.
    Perfoms a complete `Contact` fetch if there is no text field with any info.
    
    - Author: Nicolás Gebauer.
    - Date: 17-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    @IBAction func fetchContacts(sender: AnyObject) {
        if (TextFieldFirstName.text != "" ||
            TextFieldSurname.text != "" ||
            TextFieldNumber.text != "") {
                contactsManager.fetchContactsWithPredicates(
                    TextFieldFirstName.text!,
                    surname: TextFieldSurname.text!,
                    number: TextFieldNumber.text!)
        } else {
            contactsManager.fetchContacts()
        }
        deleteTextFields()
        
        ContactsTable.reloadData()
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
        if segue.identifier == nil {
            return
        } else if segue.identifier == IDShowContactCars {
            let carView = segue.destinationViewController as! CarViewController
            carView.owner = contactsTableDelegate.contactToShowCars
        }
    }

}

