//
//  AppDelegate.swift
//  Editor
//
//  Created by Romain Pouclet on 2016-01-11.
//  Copyright © 2016 Perfectly-Cooked. All rights reserved.
//

import Cocoa
import Squirrel

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet var commitMessageField: NSTextView!
    
    var path: String!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let app = aNotification.object as! NSApplication
        
        print(NSProcessInfo.processInfo())
        let path = NSProcessInfo.processInfo().arguments.filter({ ($0 as NSString).lastPathComponent == "COMMIT_MSG" }).first
        
        if let path = path {
            let contentData = try! NSData(contentsOfFile: path, options: .DataReadingUncached)
            let content = String(data: contentData, encoding: NSUTF8StringEncoding)
            commitMessageField.string = content
            
            self.path = path
        } else {
            app.terminate(self)
        }
    }
    
    @IBAction func didTapCommit(sender: AnyObject) {
        guard let content = commitMessageField.string else { return }
        
        content.dataUsingEncoding(NSUTF8StringEncoding)?.writeToFile(path, atomically: true)
        NSApp.terminate(self)
    }

}
