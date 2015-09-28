//
//  ContactsTableDelegate.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 21-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit

/** Delegate and data source of the `Contact` table.
Manages the display and deletion comand of all the contacts.
Also the access to their cars.

- Author: Nicolás Gebauer.
- Date: 21-06-15.
- Copyright: © 2015 Nicolás Gebauer.
- SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
*/
class ContactsTableDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {

    /// Reference to the `Contact` manager.
    weak var refContactManager: ContactManager!
    
    /// The `Contact` whose `cars` will be shown.
    var contactToShowCars : Contact!
    
    /// Reference to the main view controller.
    weak var refViewController: ViewController!
    
    /// Reference to the table view were the `contacts` are shown.
    weak var refContactsTable: UITableView!
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        contactToShowCars = refContactManager.contacts[indexPath.row]
        
        refViewController.performSegueWithIdentifier("IDShowContactCars", sender: refViewController)
    }
    
    // MARK: - UITableViewDataSource methods
    
    /** Sets every cell to display the information of a `Contact`.
    
    - Author: Nicolás Gebauer.
    - Date: 21-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellContact = tableView.dequeueReusableCellWithIdentifier("IDContactCell") as! ContactCell
        
        let contact = refContactManager.contacts[indexPath.row]
        
        cellContact.LabelNumber.text = contact.number
        cellContact.LabelName.text = contact.firstName + " " + (contact.surname)
        
        return cellContact
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refContactManager.contacts.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /** Deletes a `Contact` when a user chooses `delete` while editing a `contactCell`.
    
    - Author: Nicolás Gebauer.
    - Date: 21-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            refContactManager.deleteContact(indexPath.row)
            refContactManager.fetchContacts()
            refContactsTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        tableView.setEditing(false, animated: true)
    }
    
}