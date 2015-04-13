//
//  NoteSelectionVC.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 3/27/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class NoteSelectionVC: UIViewController {

    @IBOutlet weak var WButton1: UIButton!
    @IBOutlet weak var WButton2: UIButton!
    @IBOutlet weak var WButton3: UIButton!
    @IBOutlet weak var WButton4: UIButton!
    @IBOutlet weak var WButton5: UIButton!
    @IBOutlet weak var WButton6: UIButton!
    @IBOutlet weak var WButton7: UIButton!
    @IBOutlet weak var WButton8: UIButton!
    @IBOutlet weak var WButton9: UIButton!
    @IBOutlet weak var WButton10: UIButton!
    @IBOutlet weak var WButton11: UIButton!
    @IBOutlet weak var WButton12: UIButton!
    
    @IBOutlet weak var BButton1: UIButton!
    @IBOutlet weak var BButton2: UIButton!
    @IBOutlet weak var BButton3: UIButton!
    @IBOutlet weak var BButton4: UIButton!
    @IBOutlet weak var BButton5: UIButton!
    @IBOutlet weak var BButton6: UIButton!
    @IBOutlet weak var BButton7: UIButton!
    @IBOutlet weak var BButton8: UIButton!
    
    var WButtons: [UIButton]! { return [WButton1, WButton2, WButton3, WButton4, WButton5, WButton6, WButton7, WButton8, WButton9, WButton10, WButton11, WButton12] }
    var BButtons: [UIButton]! { return [BButton1, BButton2, BButton3, BButton4, BButton5, BButton6, BButton7, BButton8] }
    
    var allKeys: [UIButton]! { return [WButton1, BButton1, WButton2, BButton2, WButton3, WButton4, BButton3, WButton5, BButton4, WButton6, BButton5, WButton7, WButton8, BButton6, WButton9, BButton7, WButton10, WButton11, BButton8, WButton12] }
    
    var noteSelected: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var count = allKeys.count
        for var i = 0; i < count; i++ {
            noteSelected.append(false)
        }
        
        for wbutton in WButtons {
            wbutton.layer.borderWidth = 0.5
            wbutton.layer.borderColor = UIColor.blackColor().CGColor
            wbutton.layer.cornerRadius = 5
            wbutton.backgroundColor = UIColor.whiteColor()
        }
        
        for bbutton in BButtons {
            bbutton.layer.borderWidth = 0.5
            bbutton.layer.borderColor = UIColor.blackColor().CGColor
            bbutton.layer.cornerRadius = 5
            bbutton.backgroundColor = UIColor.blackColor()
        }

        // Do any additional setup after loading the view.
    }
    
    func keyTouched(button: UIButton, index: Int){
        if (noteSelected[index]) {
            if contains(WButtons, button) {
                button.backgroundColor = UIColor.whiteColor()
            } else {
                button.backgroundColor = UIColor.blackColor()
            }
            
            noteSelected[index] = false
        } else {
            button.backgroundColor = UIColor.greenColor()
            noteSelected[index] = true
        }
    }
    
    @IBAction func keyPressed(sender: UIButton) {
        keyTouched(sender, index: find(allKeys, sender)!)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var notes: [Int] = []
        
        var noteCount = noteSelected.count
        for var i = noteCount - 1; i >= 0; i-- {
            if noteSelected[i] {
                notes.append(i + 60)
            }
        }
        
        print("notes are: ")
        println(notes)
        
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("playableNotes", object: nil, userInfo: ["notes": notes])
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
