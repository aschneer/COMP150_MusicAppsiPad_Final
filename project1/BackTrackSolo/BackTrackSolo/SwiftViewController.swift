//
//  SwiftViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/22/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var tempoSlider: UISlider!
    var patchID : Int32 = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var patch = PdBase.openFile("demo.pd", path: NSBundle.mainBundle().resourcePath)
        patchID = PdBase.dollarZeroForFile(patch)
        // Do any additional setup after loading the view.
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
        
        println("\(ID)")
        PdBase.sendFloat(sender.value, toReceiver: ID)
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
