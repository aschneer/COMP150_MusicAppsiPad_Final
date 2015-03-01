//
//  PlayAreaViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/28/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class PlayAreaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "receiveNotes", name: "playableNotes", object: nil)
        // Do any additional setup after loading the view.
    }

    deinit {
        var center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }
    
    func receiveNotes(notification: NSNotification){
        if let info = notification.userInfo as? Dictionary<String, String> {
            var anything: AnyObject?
            var button: UIButton = anything as UIButton
            var demo = info["demo"]
            println(demo!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
