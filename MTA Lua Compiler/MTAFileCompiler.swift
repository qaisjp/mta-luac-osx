//
//  MTAFileCompiler.swift
//  MTA Lua Compiler
//
//  Created by Qais Patankar on 05/11/2014.
//  Copyright (c) 2014 qaisjp. All rights reserved.
//

import Cocoa
import Alamofire

class MTAFileCompiler: NSObject {
    let LUAC_MTASA_COM:NSURLRequest = NSURLRequest(URL: NSURL(string: "http://luac.mtasa.com/index.php")!)
    
    enum CompleteReason {case CompileError, SomeOtherError, Success, None}
    
    var responseCallback: ((CompleteReason, String?)->Void)?
    var request:Request?
    var fileURL:NSURL?
    
    init(file:NSURL, obfuscate:Bool = false, debug:Bool = false, callback:((CompleteReason, String?)->Void)?) {
        
        super.init()
    
        self.fileURL = file
        self.responseCallback = callback
        
        var parameters: [String: String] = [
            "compile": "1",
            "obfuscate": obfuscate ? "1" : "0",
            "debug": debug ? "1" : "0"
        ]
        
        var mtaURLrequest = Alamofire.ParameterEncoding.URL.encode(LUAC_MTASA_COM, parameters: parameters).0
        
        self.request = Alamofire.upload(.POST, mtaURLrequest, file)
            .response { (request,response,d,error) in
                var callback:((CompleteReason, String?)->Void)? = self.responseCallback
                
                if (error != nil) {
                    println(error)
                    if (callback != nil) {
                        println("Output")
                        callback!(.SomeOtherError, nil)
                    }
                    return
                }
                
                var data:NSData = d as NSData
                
                var str = NSString(data:data, encoding:NSUTF8StringEncoding)
                if (str != nil) {
                    // Error! str is not null if plain text is returned
                    println("Error: " + str!)
                    if (callback != nil) {
                        callback!(.CompileError, str! + " (\(file.lastPathComponent))" )
                    }
                    return
                }
                
                // Time to save to file
                data.writeToURL(file.URLByAppendingPathExtension("luac"), atomically: true)
                
                if callback != nil {
                    callback!(CompleteReason.Success, nil)
                }
                
            }
    }
}
