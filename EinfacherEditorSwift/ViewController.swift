//
//  ViewController.swift
//  EinfacherEditorSwift
//
//  Created by Christoph Siebeck
//  Copyright © 2017 Christoph Siebeck. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var fileHandler = filehandler(aFileTypes: ["txt"])

    @IBOutlet weak var meinTextfeld: NSTextField!
    
    @IBAction func ladenClicked(sender: AnyObject) {
        let bIsLoaded = fileHandler.load(bCreateBackup: true, field: meinTextfeld)
        
        if bIsLoaded {
            print("load 1")
        }
        else {
            print("load 0")
        }
    }
    
    //die Action für das Speichern
    @IBAction func speichernClicked(sender: AnyObject) {
        let bIsSave = fileHandler.save(field: meinTextfeld)
        
        if bIsSave {
            print("save 1")
        }
        else {
            print("save 0")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

