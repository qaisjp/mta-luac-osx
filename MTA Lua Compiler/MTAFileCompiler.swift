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
    
    init(file:NSURL, obfuscate:Bool = false, debug:Bool = false) {
        super.init()
    
        println("Received " + file.absoluteString!)
        
        var parameters: [String: String] = [
            "compile": "1",
            "obfuscate": toString(obfuscate),
            "debug": toString(debug)
        ]
        
        
        var test = Alamofire.ParameterEncoding.URL.encode(LUAC_MTASA_COM, parameters: parameters)
        
        
        var upload = Alamofire.upload(.POST, test.0, file)
            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
            println("Total bytes written \(totalBytesWritten)")
        }

        .response { (request,response,d,error) in
            var data:NSData = d as NSData
            var str = NSString(data:data, encoding:NSUTF8StringEncoding)
            
            println(data)
            println(str)
        }
    }
}
