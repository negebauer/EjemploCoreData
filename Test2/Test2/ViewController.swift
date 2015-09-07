//
//  ViewController.swift
//  Test2
//
//  Created by Nicolás Gebauer on 02-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NSHost.currentHost()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

