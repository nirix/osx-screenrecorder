//
//  ScreenRecorder.swift
//  ScreenRecorder
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Foundation
import AVFoundation

class ScreenRecorder: NSObject, AVCaptureFileOutputRecordingDelegate {
    var mSession: AVCaptureSession?
    var mMovieFileOutput: AVCaptureMovieFileOutput?
    
    func screenRecording(destPath: NSURL) {
        mSession = AVCaptureSession()
        mSession?.sessionPreset = AVCaptureSessionPresetHigh
        
        let displayId: CGDirectDisplayID = CGDirectDisplayID(CGMainDisplayID())
        
        let input: AVCaptureScreenInput = AVCaptureScreenInput(displayID: displayId)
        
        if (input == false) {
            mSession = nil
            return
        }
        
        if ((mSession?.canAddInput(input)) != nil) {
            mSession?.addInput(input)
        }
        
        mMovieFileOutput = AVCaptureMovieFileOutput()
        
        if ((mSession?.canAddOutput(mMovieFileOutput)) != nil) {
            mSession?.addOutput(mMovieFileOutput)
        }
        
        mSession?.startRunning()
        
        mMovieFileOutput?.startRecordingToOutputFileURL(destPath, recordingDelegate: self)
    }
    
    func finishRecord() {
        mMovieFileOutput?.stopRecording()
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        mSession?.stopRunning()
        mSession = nil
    }
}
