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
        volumeSlider.value = 1
        super.viewDidLoad()
        var patch = PdBase.openFile("main.pd", path: NSBundle.mainBundle().resourcePath)
        patchID = PdBase.dollarZeroForFile(patch)
        PdBase.sendFloat(1, toReceiver: "progression")
        
        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "receiveNote:", name: "noteToPlay", object: nil)
    }
    
    deinit {
        var center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }

    func receiveNote(notification: NSNotification){
        if let info = notification.userInfo as? Dictionary<String, Float> {
            var note = info["play"]
            
            println(note)
            
            PdBase.sendFloat(note!, toReceiver: "MIDI_pitch")
            PdBase.sendFloat(1, toReceiver: "MIDI_vel")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeVolume(sender: UISlider) {
        PdBase.sendFloat(sender.value, toReceiver: "volume")
    }
    
    @IBAction func changeTempo(sender: UISlider) {
        var tempo : Float = (sender.value - 0.5) * 40000
        println(tempo)
        PdBase.sendFloat(tempo, toReceiver: "tempo")
        
    }
    
    @IBAction func Play(sender: UIButton) {
        PdBase.sendBangToReceiver("play")
    }
    
    @IBAction func Pause(sender: UIButton) {
        PdBase.sendBangToReceiver("pause")
        PdBase.sendFloat(60, toReceiver: "MIDI_pitch")
        PdBase.sendFloat(1, toReceiver: "MIDI_vel")
    }
    
    @IBAction func Stop(sender: UIButton) {
        PdBase.sendFloat(0, toReceiver: "MIDI_vel")
        PdBase.sendBangToReceiver("stop")
    }
    
    @IBAction func selectNotes(sender: UIButton) {
        var noteSelection = NoteSelectionViewController(nibName: "noteSelection", bundle: nil)
        var noteController = UIPopoverController(contentViewController: noteSelection)
        
        noteController.popoverContentSize = CGSize(width: 980, height: 500)
        
        noteController.presentPopoverFromRect(sender.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Down, animated: true)
    }
}
