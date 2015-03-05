//
//  NoteSelectionViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/28/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class NoteSelectionViewController: UIViewController,UIPickerViewDelegate{

    @IBOutlet weak var sendNotes: UIButton!
    
    
    //var notes = [Int]()
    var notes : [Int] = [60, 62, 64, 65, 67, 69, 71, 72]
    
    @IBOutlet weak var Switch1: UISwitch!
    @IBOutlet weak var Switch2: UISwitch!
    @IBOutlet weak var Switch3: UISwitch!
    @IBOutlet weak var Switch4: UISwitch!
    @IBOutlet weak var Switch5: UISwitch!
    @IBOutlet weak var Switch6: UISwitch!
    @IBOutlet weak var Switch7: UISwitch!
    @IBOutlet weak var Switch8: UISwitch!
    @IBOutlet weak var Switch9: UISwitch!
    @IBOutlet weak var Switch10: UISwitch!
    @IBOutlet weak var Switch11: UISwitch!
    @IBOutlet weak var Switch12: UISwitch!
    @IBOutlet weak var Switch13: UISwitch!
    @IBOutlet weak var Switch14: UISwitch!
    @IBOutlet weak var Switch15: UISwitch!
    @IBOutlet weak var Switch16: UISwitch!
    
    @IBOutlet weak var KeyPicker: UIPickerView!
    @IBOutlet weak var ProgressionPicker: UIPickerView!
    
    
    //KeyPicker setup
    var keys = ["A", "B", "C", "D", "E", "F", "G"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return keys.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return keys[row]
    }

    
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
