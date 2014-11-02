//
//  MTAWindowController.swift
//  MTA Lua Compiler
//
//  Created by Qais Patankar on 02/11/2014.
//  Copyright (c) 2014 qaisjp. All rights reserved.
//

import Cocoa

class MTAWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        var wnd:NSWindow = self.window!
        
        wnd.titleVisibility = NSWindowTitleVisibility.Hidden
    }
    
 

}
