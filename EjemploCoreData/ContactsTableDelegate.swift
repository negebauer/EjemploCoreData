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

    // MARK: - UITableViewDelegate methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    // MARK: - UITableViewDataSource methods
    
    /** Sets every cell to display the information of a `Contact`.
    
    - Author: Nicolás Gebauer.
    - Date: 21-06-15.
    - Copyright: © 2015 Nicolás Gebauer.
    - SeeAlso: [Website](http://nicogeb.github.io/EjemploCoreData/).
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
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

        }
        tableView.setEditing(false, animated: true)
    }

}