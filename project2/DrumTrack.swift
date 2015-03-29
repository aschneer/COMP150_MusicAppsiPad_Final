//
//  DrumTrack.swift
//  project2
//
//  Created by Margaret Feltz on 3/29/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

import UIKit

class DrumTrack: UIViewController {

    
    @IBOutlet weak var ChordPicker: UIPickerView!
    let pickerData = [
        ["A", "B", "C", "D", "E", "F", "G"],
        ["M", "m"],
        ["7", "9"]
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChordPicker.description

        // Do any additional setup after loading the view.
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
