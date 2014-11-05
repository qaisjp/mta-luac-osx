//
//  MTAMainViewController.swift
//  MTA Lua Compiler
//
//  Created by Qais Patankar on 05/11/2014.
//  Copyright (c) 2014 qaisjp. All rights reserved.
//

import Cocoa

class MTAMainViewController: NSViewController {
    var parameters: Array<NSURL>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        let second = segue.destinationController as FileManagerViewController
        second.representedObject = self
    }
    
    
    @IBOutlet weak var obfuscateCheckbox: NSButton!
    @IBAction func onCompilePress(sender: AnyObject) {
        
        if (parameters == nil) {
            println("choose files first")
            return
        }
        
        var shouldObfuscate: Bool = obfuscateCheckbox.state == NSOnState

        var compiler: MTAFileCompiler = MTAFileCompiler(file: parameters![0], obfuscate: shouldObfuscate, debug: false)
    }
    
}
