//
//  NoteSelectionViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/28/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class NoteSelectionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var sendNotes: UIButton!
    
    

    /*
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
    */
    
    //var notes = [Int]()
    
    @IBOutlet var notes: [UISwitch]!
    

    @IBOutlet weak var KeyPicker: UIPickerView!
    
    
    //KeyPicker setup
    var pickerData = [
        ["A", "B", "C", "D", "E", "F", "G"],
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
        KeyPicker.delegate = self
        KeyPicker.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var notesOn: [Int];
    
    @IBAction func switchesTriggered(sender: UISwitch) {
        for item in notes {
            if item.on {
                println("switch is on")
            }
            else if !item.on{
                println("switch is off")
            }
        }
        
    }
    
    
    @IBAction func sendNotes(sender: UIButton) {
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("playableNotes", object: nil, userInfo: ["notes": notes])
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
