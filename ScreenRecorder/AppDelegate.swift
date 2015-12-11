//
//  AppDelegate.swift
//  ScreenRecorder
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var startBtn: NSButton!
    @IBOutlet weak var stopBtn: NSButton!
    @IBOutlet weak var pathField: NSTextField!
    
    var moviePath: String?
    var recorder: ScreenRecorder?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        recorder = ScreenRecorder()
        
        startBtn.enabled = false
        stopBtn.enabled = false
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func setMovieSavePath(sender: AnyObject?) {
        let openPanel = NSSavePanel()

        openPanel.beginWithCompletionHandler({ result in
            if (result == NSFileHandlingPanelOKButton) {
                self.moviePath = "\(openPanel.URL!.path!)"
                self.pathField.stringValue = self.moviePath!
                self.startBtn.enabled = true
                self.stopBtn.enabled = true
            }
        })
    }

    @IBAction func startRecording(sender: AnyObject?) {
        let dest = NSURL(fileURLWithPath: pathField.stringValue)
        recorder?.screenRecording(dest)
    }
    
    @IBAction func stopRecording(sender: AnyObject?) {
        recorder?.finishRecord()
    }
}

