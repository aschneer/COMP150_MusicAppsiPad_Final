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
    @IBOutlet weak var tremoloSwitch: UISwitch!
    var tremolo : Float = 0.0
    var patchID : Int32 = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        volumeSlider.value = 1
        tremoloSwitch.on = false
        super.viewDidLoad()
        var patch = PdBase.openFile("main.pd", path: NSBundle.mainBundle().resourcePath)
        patchID = PdBase.dollarZeroForFile(patch)
        PdBase.sendFloat(1, toReceiver: "progression")
        
        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "receiveNote:", name: "noteToPlay", object: nil)
        center.addObserver(self, selector: "noteToStop:", name: "stopNote", object: nil)
        center.addObserver(self, selector: "toggleTremolo:", name: "tremolo", object: nil)
    }
    
    deinit {
        var center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }

    func receiveNote(notification: NSNotification){
        if let info = notification.userInfo as? Dictionary<String, Float> {
            var note = info["play"]
            
            PdBase.sendList([note!, 1], toReceiver: "MIDI_message")
        }
    }
    
    func noteToStop(notification: NSNotification){
        if let info = notification.userInfo as? Dictionary<String, Float> {
            var note = info["stop"]
            
            PdBase.sendList([note!, 0], toReceiver: "MIDI_message")
        }
    }
    
    @IBAction func toggleTremolo(sender: UISwitch) {
        if tremolo == 0.0 {
            tremolo = 1.0
        } else if tremolo == 1.0 {
            tremolo = 0.0
            
        }
        println(tremolo)
        PdBase.sendFloat(tremolo, toReceiver: "tremolo")
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
        PdBase.sendFloat(tempo, toReceiver: "tempo_in")
        
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
