//
//  class.filehandler.swift
//  EinfacherEditorSwift
//
//  Created by Magnus Kruschwitz on 19.10.19.
//  Copyright © 2019 Christoph Siebeck. All rights reserved.
//

import Foundation
import Cocoa

class filehandler {
    private var aFileTypes : Array<String>
    private var iSaveCounter : Int
    private var bIsLoad : Bool
    private var sFile : String?
    
    init(aFileTypes : Array<String>) {
        self.aFileTypes = aFileTypes
        self.iSaveCounter = 0
        self.bIsLoad = false
    }
    
    func save(field: NSTextField) -> Bool {
        if self.iSaveCounter > 0 || self.bIsLoad {
            
        }
        else {
            let mySaveDialog = NSSavePanel()
            
            mySaveDialog.title = "Speichern unter"
            mySaveDialog.prompt = "Speichern unter"
            mySaveDialog.allowedFileTypes = self.aFileTypes
            
            if mySaveDialog.runModal() == NSModalResponseOK {
                self.sFile = mySaveDialog.url?.path
                let textTemp = field.stringValue
                
                do {
                    try textTemp.write(toFile: self.sFile!, atomically: true, encoding: String.Encoding.utf8)
                    
                    self.iSaveCounter += 1
                    
                    return true
                }
                catch {
                    print("Es hat ein Problem gegeben!")
                    return false
                }
            }
        }
        
        return false
    }
    
    func load(bCreateBackup: Bool, field: NSTextField) -> Bool {
        let myOpenPanel = NSOpenPanel()
        myOpenPanel.title = "Öffnen"
        myOpenPanel.prompt = "Öffnen"
        myOpenPanel.allowedFileTypes = self.aFileTypes
        
        if myOpenPanel.runModal() == NSModalResponseOK {
            self.sFile = myOpenPanel.url?.path
            
            do {
                var bBackupResult = false
                let textTemp = try String(contentsOfFile:self.sFile!, encoding:
                    String.Encoding.utf8)
                field.stringValue = textTemp
                
                if bCreateBackup {
                    bBackupResult = self.createBackUp(file: self.sFile!, content: textTemp)
                }
                
                self.bIsLoad = true
                
                if bBackupResult {
                    print("Backup wurde angelegt")
                }
                else {
                    if bCreateBackup {
                        print("Es ist ein Fehler aufgetreten, bitte prüfen Sie den Fehlerlog")
                    }
                }
                
                return true
            }
            catch {
                print(error.localizedDescription)
                return false
            }
        }
        
        return false
    }
    
    func createBackUp(file: String, content: String) -> Bool {
        let oFileManager = FileManager.default
        let backupURL = URL(string: "\((file as NSString).deletingPathExtension).bak")
        
        do {
            if oFileManager.fileExists(atPath: (backupURL?.path)!) {
                print("Backup existiert.")
                print("Lösche vorhandens Backup und lege ein Neues an.")
                try oFileManager.removeItem(atPath: (backupURL?.absoluteString)!)
                print("Backupfile gelöscht")
            }
            else {
                print("Backup existiert nicht")
            }
            
            print("lege Backup an.")
            try content.write(toFile: "\((file as NSString).deletingPathExtension).bak",atomically: true, encoding: .utf8)
            print("Backup erfolgreich angelegt unter \(String(describing: backupURL?.absoluteString)).")
            
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
}
