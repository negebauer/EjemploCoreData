//
//  ViewController.swift
//  Test
//
//  Created by Nicolás Gebauer on 06-07-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let timer = NSTimer(timeInterval: 1, target: self, selector: "timedFunction", userInfo: nil, repeats: true)
        let timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timedFunction2", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: "")
        NSRunLoop.currentRunLoop().addTimer(timer2, forMode: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func timedFunction() {
        NSLog("Timer fired")
    }
    
    func timedFunction2() {
        NSLog("Timer fired 2")
    }
}

