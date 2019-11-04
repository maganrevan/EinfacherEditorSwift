//
//  ViewController.swift
//  EinfacherEditorSwift
//
//  Created by Christoph Siebeck & Magnus Kruschwitz
//  Copyright © 2017 Christoph Siebeck. All rights reserved.
//  Copyright © 2019 Magnus Kruschwitz. All rights reserved. (Betrifft die erweiterten Funktionalitäten)
//

import Cocoa

class ViewController: NSViewController {
    
    var helper = helperClass(aFileTypes: ["txt"])

    @IBOutlet weak var meinTextfeld: NSTextField!
    
    @IBAction func ladenClicked(sender: AnyObject) {
        let bIsLoaded = helper.load(bCreateBackup: true, field: meinTextfeld)
        
        if bIsLoaded {
            print("load 1")
        }
        else {
            print("load 0")
        }
    }
    
    @IBAction func speichernAlsClicked(sender: AnyObject) {
        let bIsSave = helper.save(field: meinTextfeld, bforceSavePanel: true)
        
        if bIsSave {
            print("save 1")
        }
        else {
            print("save 0")
        }
    }
    
    //die Action für das Speichern
    @IBAction func speichernClicked(sender: AnyObject) {
        let bIsSave = helper.save(field: meinTextfeld, bforceSavePanel: false)
        
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

