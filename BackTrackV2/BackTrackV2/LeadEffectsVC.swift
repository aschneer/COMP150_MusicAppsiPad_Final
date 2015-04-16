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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tremoloChanged(tremoloSlider)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tremoloChanged(sender: UISlider) {
        //var center = NSNotificationCenter.defaultCenter()
        //center.postNotificationName("setFreq", object: nil, userInfo: ["freq": CGFloat(sender.value) / 50])
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
