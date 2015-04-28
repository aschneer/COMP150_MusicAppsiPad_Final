//
//  MainVC.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 3/27/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var currChord: UILabel!
    @IBOutlet weak var nextChord: UILabel!
    
    var initialized = false
    var NoteSelectionController: NoteSelectionVC!
    var BackTrackController: BTVC!
    var HelpController: HelpVC!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        NoteSelectionController = storyboard.instantiateViewControllerWithIdentifier("NoteSelection") as! NoteSelectionVC
        BackTrackController = storyboard.instantiateViewControllerWithIdentifier("BackingTrack") as! BTVC
        HelpController = storyboard.instantiateViewControllerWithIdentifier("HelpScreen") as! HelpVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeCurrChord(chord1: String, chord2: String) {
        currChord.text = chord1
        nextChord.text = chord2
    }
    
    @IBAction func changeTempo(sender: UISlider) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("setBPM", object: nil, userInfo: ["freq": sender.value])
    }
    
    @IBAction func changeVolume(sender: UISlider) {
        PdBase.sendFloat(sender.value, toReceiver: "volume")
    }
    
    @IBAction func playBackingTrack(sender: UIButton) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("playBackingTrack", object: nil, userInfo: nil)
    }

    @IBAction func pauseBackingTrack(sender: UIButton) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("pauseBackingTrack", object: nil, userInfo: nil)
    }
    
    @IBAction func stopBackingTrack(sender: UIButton) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("stopBackingTrack", object: nil, userInfo: nil)
    }
    
    // MARK: - Navigation
    @IBAction func displayNoteSelectionVC(sender: AnyObject) {
        self.presentViewController(NoteSelectionController, animated: true, completion: nil)
    }
    
    @IBAction func displayBackingTrackVC(sender: AnyObject) {
        self.presentViewController(BackTrackController, animated: true, completion: nil)
    }

    @IBAction func displayHelpScreen(sender: UIButton) {
        self.presentViewController(HelpController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        // Do Nothing
    }
    
    

}
