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
    var currentCompiler: MTAFileCompiler?
    
    @IBOutlet weak var fileManagerButton: NSButton!
    @IBOutlet weak var compileBtn: NSButton!
    @IBOutlet weak var obfuscateCheckbox: NSButton!
    @IBOutlet weak var uploadProgress: NSProgressIndicator!
    @IBOutlet weak var fileProgress: NSLevelIndicator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        let second = segue.destinationController as FileManagerViewController
        second.representedObject = self
    }
    
    
    @IBOutlet weak var messageField: NSTextField!
    func setMessage(message: NSString) {
        messageField.stringValue = message
        println("setMessage: " + message)
    }

    @IBAction func onButtonPress(sender: NSButton) {
        if (currentCompiler != nil) {
            // Do some cancel stuff
            currentCompiler?.request?.cancel()
            onCompileFinish(MTAFileCompiler.CompleteReason.None, error: "Compile cancelled")
            return
        }
        
        if (parameters == nil) {
            setMessage("No files have been selected")
            return
        }
        
        compileBtn.title = "Cancel"
        fileManagerButton.enabled = false
        
        var numberFormatter = NSNumberFormatter()
        numberFormatter.format = "0"
        
        var shouldObfuscate: Bool = obfuscateCheckbox.state == NSOnState

        currentCompiler = MTAFileCompiler(file: parameters![0], obfuscate: shouldObfuscate, debug: false, callback: onCompileFinish)
        
        var progressMessage: String = "Uploading \"\(currentCompiler!.fileURL!.lastPathComponent)\""
        
        currentCompiler!.request!.progress { (written, total, expected) in
            var percent:Double = Double(total) / Double(expected) * 100
            var message = progressMessage + " (\(numberFormatter.stringFromNumber(percent)!)%)"
            self.setMessage(message)
            self.uploadProgress.doubleValue = percent
        }
        
    }
    
    func onCompileFinish(reason: MTAFileCompiler.CompleteReason, error: String?) {
        compileBtn.title = "Compile files"
        fileManagerButton.enabled = true
        
        switch reason {
        case .Success:
            self.setMessage("Compiled \"\(currentCompiler!.fileURL!.lastPathComponent)\"")
        case .CompileError:
            self.setMessage(error!)
        case .SomeOtherError:
            self.setMessage("Internal error. Please try again.")
        case .None:
            if error != nil {
                self.setMessage(error!)
            }
        }
        
        currentCompiler = nil
    }
    
}
