//
//  MTAFileCompiler.swift
//  MTA Lua Compiler
//
//  Created by Qais Patankar on 05/11/2014.
//  Copyright (c) 2014 qaisjp. All rights reserved.
//

import Cocoa

class MTAFileCompiler: NSObject {
    let LUAC_MTASA_COM = NSURL(string: "http://luac.mtasa.com/index.php")
    
    init(file:NSURL) {
        super.init()
    
        // Throw up if not a file URL passed
        assert(file.isFileReferenceURL(), "NSURL passed to MTAFileCompiler init is not a file ref URL")
        
    }
    
}
