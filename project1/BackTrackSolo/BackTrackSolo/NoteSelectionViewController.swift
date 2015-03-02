//
//  NoteSelectionViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/28/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class NoteSelectionViewController: UIViewController {

    @IBOutlet weak var sendNotes: UIButton!
    
    
    //var notes = [Int]()
    var notes : [Int] = [60, 62, 64, 65, 67, 69, 71, 72]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func sendNotes(sender: UIButton) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("playableNotes", object: nil, userInfo: ["notes": notes])
    }

}
