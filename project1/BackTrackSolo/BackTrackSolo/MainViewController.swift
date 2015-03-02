//
//  MainViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/28/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var tempoSlider: UISlider!
    var patchID : Int32 = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var patch = PdBase.openFile("piano_test.pd", path: NSBundle.mainBundle().resourcePath)
        patchID = PdBase.dollarZeroForFile(patch)
        
        // Initialize volume and tempo
        var midiNote : String = String(patchID) + "-midinote"
        PdBase.sendFloat(60, toReceiver: midiNote)
        var beatsPerMeasure : String = String(patchID) + "-beatsPerMeasure"
        PdBase.sendFloat(4, toReceiver: beatsPerMeasure)
        
        var volumeSend : String = String(patchID) + "-volume"
        PdBase.sendFloat(0.5, toReceiver: volumeSend)
        var tempoSend : String = String(patchID) + "-tempo"
        PdBase.sendFloat(120, toReceiver: tempoSend)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeVolume(sender: UISlider) {
        var ID : String = String(patchID)
        ID += "-volume"
        
        println("\(ID)")
        PdBase.sendFloat(sender.value, toReceiver: ID)
    }
    
    @IBAction func changeTempo(sender: UISlider) {
        var ID : String = String(patchID)
        ID += "-tempo"
        var tempoBPM : Int = 0
        tempoBPM = 50 + (Int(sender.value) * 250)
        
        println("\(ID)")
        PdBase.sendFloat(Float(tempoBPM), toReceiver: ID)
    }
    
    @IBAction func Play(sender: UIButton) {
        var playSend : String = String(patchID) + "-backingTrackStatus"
        PdBase.sendFloat(1, toReceiver: playSend)
    }
    
    @IBAction func Stop(sender: UIButton) {
        var stopSend : String = String(patchID) + "-backingTrackStatus"
        PdBase.sendFloat(0, toReceiver: stopSend)
    }
    
    @IBAction func selectNotes(sender: UIButton) {
        var noteSelection = NoteSelectionViewController(nibName: "noteSelection", bundle: nil)
        var noteController = UIPopoverController(contentViewController: noteSelection)
        
        noteController.popoverContentSize = CGSize(width: 980, height: 500)
        
        noteController.presentPopoverFromRect(sender.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Down, animated: true)
    }
}
