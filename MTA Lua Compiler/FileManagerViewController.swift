//
//  FileManagerViewController.swift
//  MTA Lua Compiler
//
//  Created by Qais Patankar on 02/11/2014.
//  Copyright (c) 2014 qaisjp. All rights reserved.
//

import Cocoa

class FileManagerViewController: NSViewController {
    
    var urls: Array<NSURL>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClosePressed(sender: AnyObject) {
        self.dismissController(self)

        if (urls != nil) {
            (self.representedObject as MTAMainViewController).parameters = urls!
        }
    }
    
    @IBOutlet weak var fileTableView: NSTableView!
    @IBAction func onBrowseClick(sender: AnyObject) {
        // Create the File Open Dialog class.
        var panel:NSOpenPanel = NSOpenPanel();
        
        panel.canChooseFiles = true;
        panel.canChooseDirectories = false;
        panel.title = "Select file(s) or folder(s) to compile";
        panel.allowsMultipleSelection = true;
        
        
        // Display the dialog.  If the OK button was pressed, process the path
        var buttonPressed:NSInteger = panel.runModal();
        if ( buttonPressed == NSOKButton ) {
            self.urls = panel.URLs as? Array<NSURL>
        }
        
    }

    
}

