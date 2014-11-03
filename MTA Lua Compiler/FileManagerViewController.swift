//
//  FileManagerViewController.swift
//  MTA Lua Compiler
//
//  Created by Qais Patankar on 02/11/2014.
//  Copyright (c) 2014 qaisjp. All rights reserved.
//

import Cocoa

class FileManagerViewController: NSViewController {
    
    weak var filePath:NSURL!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onClosePressed(sender: AnyObject) {
        self.dismissController(self)
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
            var url:NSURL = panel.URLs[0] as NSURL;
            filePath = url
        }
        
    }

}

