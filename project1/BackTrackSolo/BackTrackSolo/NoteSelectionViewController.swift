//
//  NoteSelectionViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/28/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class NoteSelectionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var sendNotes: UIButton!
    
    
    //var notes = [Int]()
    var notes : [Int] = []
    var notesSelected : [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    
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
    
    
    //KeyPicker setup
    var pickerData = [
        ["C", "D", "E", "F", "G", "A", "B"],
        ["Blues-Fast", "Blues-Medium", "Blues-Slow"]
    ]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[component][row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "toggleSwitches:", name: "noteSelections", object: nil)
        center.postNotificationName("pleaseSend", object: nil, userInfo: nil)
        KeyPicker.delegate = self
        KeyPicker.dataSource = self
    }
    
    func toggleSwitches(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<String, [Bool]> {
            var note = info["selections"]
            Switch1.on = note![0]
            Switch2.on = note![1]
            Switch3.on = note![2]
            Switch4.on = note![3]
            Switch5.on = note![4]
            Switch6.on = note![5]
            Switch7.on = note![6]
            Switch8.on = note![7]
            Switch9.on = note![8]
            Switch10.on = note![9]
            Switch11.on = note![10]
            Switch12.on = note![11]
            Switch13.on = note![12]
            Switch14.on = note![13]
            Switch15.on = note![14]
            Switch16.on = note![15]
        }
    }
    
    deinit {
        var center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func sendNotes(sender: UIButton) {
        if Switch1.on {
            notes.append(60)
            notesSelected[0] = true
        } else {
            notesSelected[0] = false
        }
        
        if Switch2.on {
            notes.append(61)
            notesSelected[1] = true
        } else {
            notesSelected[1] = false
        }
        
        if Switch3.on {
            notes.append(62)
            notesSelected[2] = true
        } else {
            notesSelected[2] = false
        }
        
        if Switch4.on {
            notes.append(63)
            notesSelected[3] = true
        } else {
            notesSelected[3] = false
        }
        
        if Switch5.on {
            notes.append(64)
            notesSelected[4] = true
        } else {
            notesSelected[4] = false
        }
        
        if Switch6.on {
            notes.append(65)
            notesSelected[5] = true
        } else {
            notesSelected[5] = false
        }
        
        if Switch7.on {
            notes.append(66)
            notesSelected[6] = true
        } else {
            notesSelected[6] = false
        }
        
        if Switch8.on {
            notes.append(67)
            notesSelected[7] = true
        } else {
            notesSelected[7] = false
        }
        
        if Switch9.on {
            notes.append(68)
            notesSelected[8] = true
        } else {
            notesSelected[8] = false
        }
        
        if Switch10.on {
            notes.append(69)
            notesSelected[9] = true
        } else {
            notesSelected[9] = false
        }
        
        if Switch11.on {
            notes.append(70)
            notesSelected[10] = true
        } else {
            notesSelected[10] = false
        }
        
        if Switch12.on {
            notes.append(71)
            notesSelected[11] = true
        } else {
            notesSelected[11] = false
        }
        
        if Switch13.on {
            notes.append(72)
            notesSelected[12] = true
        } else {
            notesSelected[12] = false
        }
        
        if Switch14.on {
            notes.append(73)
            notesSelected[13] = true
        } else {
            notesSelected[13] = false
        }
        
        if Switch15.on {
            notes.append(74)
            notesSelected[14] = true
        } else {
            notesSelected[14] = false
        }
        
        if Switch16.on {
            notes.append(75)
            notesSelected[15] = true
        } else {
            notesSelected[15] = false
        }
        
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("playableNotes", object: nil, userInfo: ["notes": notes])
        center.postNotificationName("notesForMain", object: nil, userInfo: ["myNotes": notesSelected])
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
