//
//  LeadEffectsVC.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 3/31/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class LeadEffectsVC: UIViewController {

    @IBOutlet weak var tremoloSlider: UISlider!
    @IBOutlet weak var ASlider: UISlider!
    @IBOutlet weak var DSlider: UISlider!
    @IBOutlet weak var SSlider: UISlider!
    @IBOutlet weak var RSlider: UISlider!
    
    var SLIDER: CGFloat = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tremoloSlider.value = 0.0
        //tremoloChanged(tremoloSlider)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reverbChanged(sender: UISlider) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("setReverb", object: nil, userInfo: ["freq": (sender.value * 126.5) + 0.01])
    }
    
    @IBAction func attackChanged(sender: UISlider) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("setAttack", object: nil, userInfo: ["freq": (sender.value * 1000) + 0.01])
    }
    
    @IBAction func decayChanged(sender: UISlider) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("setDecay", object: nil, userInfo: ["freq": (sender.value * 1000) + 0.01])
    }
    
    @IBAction func sustainChanged(sender: UISlider) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("setSustain", object: nil, userInfo: ["freq": sender.value + 0.01])
    }
    
    @IBAction func releaseChanged(sender: UISlider) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("setRelease", object: nil, userInfo: ["freq": (sender.value * 1000) + 100])
    }
    
    @IBAction func tremoloChanged(sender: UISlider) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("setFreq", object: nil, userInfo: ["freq": (sender.value * 2.5) + 0.01])
        
        //PdBase.sendList([sender.value, 0.2, 0], toReceiver: "vibrato")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
