//
//  BTVC.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 3/27/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class BTVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet var ProgScrollView: UIScrollView!
    
    @IBOutlet weak var selectedChord: UILabel!
    
    @IBOutlet weak var PianoSwitch: UISwitch!
    @IBOutlet weak var GuitarSwitch: UISwitch!
    @IBOutlet weak var BassSwitch: UISwitch!
    @IBOutlet weak var Other: UISwitch!
    
    @IBOutlet weak var AddChordButton: UIButton!
    @IBOutlet weak var DeleteChordButton: UIButton!
    @IBOutlet weak var ClearAllButton: UIButton!
    
    
    
    @IBOutlet weak var ChordLabel: UILabel!
    @IBOutlet weak var PianoLabel: UILabel!
    @IBOutlet weak var GuitarLabel: UILabel!
    @IBOutlet weak var BassLabel: UILabel!
    @IBOutlet weak var DrumsLabel: UILabel!
    
    //var LabelList: [UILabel]! {return [PianoLabel, GuitarLabel, BassLabel, DrumsLabel]}
    //var ButtonList: [UIButton]! {return [AddChordButton, DeleteChordButton, ClearAllButton]}
    //ChordLabel.font = UIFont(name: "KohinoorDevanagari-Light", size: 45)
    
    @IBOutlet weak var ChordPicker: UIPickerView!
    let pickerData = [
        ["A", "B", "C", "D", "E", "F", "G"],
        ["♮", "♯", "♭"],
        ["Maj", "Min", "Aug", "Dim"],
        ["Triad", "7", "9"],
        ["1 beat", "2 beats", "3 beats"]
    ]
    
    //var touch = 0
    
    var chords: [UIView] = []
    override func viewDidLoad() {
        //println(view.backgroundColor)
        super.viewDidLoad()
        
        /*for button in ButtonList {
            button.titleLabel!.font = UIFont(name: "KohinoorDevanagari-Light", size: 30)
        }
        for label in LabelList {
            label.font = UIFont(name: "KohinoorDevanagari-Light", size: 30)
        }*/
        
        ProgScrollView.contentSize = CGSizeMake(3000, 128)
        
        ChordPicker.dataSource = self
        ChordPicker.delegate = self
        ChordPicker.backgroundColor = UIColor(red: 1.0, green: 250/255, blue: 240/255, alpha: 0.7)
        ChordPicker.layer.cornerRadius = 15
        ChordPicker.layer.borderColor = UIColor.blackColor().CGColor
        ChordPicker.layer.borderWidth = 5
        selectedChord.textAlignment = .Center
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
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30.0
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {
            pickerLabel = UILabel()
            //let hue = CGFloat(row) / CGFloat(pickerData.count)
            //pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)

        }
        
        let titleData = pickerData[component][row]
        let rowTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName: UIFont(name: "KohinoorDevanagari-Light", size: 24.0)!, NSForegroundColorAttributeName: UIColor.blackColor()])
        pickerLabel!.attributedText = rowTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
        
    }
    
    func updateLabel() -> String {
        var root = pickerData[0][ChordPicker.selectedRowInComponent(0)]
        var sharpOrFlat = pickerData[1][ChordPicker.selectedRowInComponent(1)]
        var majOrMin = pickerData[2][ChordPicker.selectedRowInComponent(2)]
        var chord = pickerData[3][ChordPicker.selectedRowInComponent(3)]
        var beatlength = pickerData[4][ChordPicker.selectedRowInComponent(4)]
        
        var label = root
        
        if sharpOrFlat != "♮" {
            label += sharpOrFlat
        }
        
        label += "-"
        
        if majOrMin == "Maj" {
            label += "M"
        }
        if majOrMin == "Min" {
            label += "m"
        }
        if majOrMin == "Aug" {
            label += "aug"
        }
        if majOrMin == "Dim" {
            label += "dim"
        }
        
        if chord != "Triad" {
            label += chord
        }
        
        label += " " + "for " + beatlength
        /*if beatlength == "1 beat" {
            label += " " + "for " + beatlength
        }*/
        
        selectedChord.text = label
        selectedChord.textAlignment = .Center
        return label
    }
    
    //values for chord scroll bar view placement
    var top = 0.0
    var left = 0.0
    var width = 100.0
    var height = 128.0
    
    //Function to add chord to chord scrollview
    @IBAction func AddChord(sender: UIButton) {
        //ChordPicker information for label and width
        var root = pickerData[0][ChordPicker.selectedRowInComponent(0)]
        var sharpOrFlat = pickerData[1][ChordPicker.selectedRowInComponent(1)]
        var majOrMin = pickerData[2][ChordPicker.selectedRowInComponent(2)]
        var chord = pickerData[3][ChordPicker.selectedRowInComponent(3)]
        var beat = pickerData[4][ChordPicker.selectedRowInComponent(4)]
        
        if(beat == "2 beats"){
            width *= 2
        }
        if(beat == "3 beats"){
            width *= 3
        }
        if(left <= 2900){
            //creating uiview for each chord added
            var chordView = UIView(frame: CGRectMake(CGFloat(left),CGFloat(top),CGFloat(width),CGFloat(height)))
            chordView.backgroundColor = UIColor.whiteColor()
            chordView.layer.borderColor = UIColor.blackColor().CGColor
            chordView.layer.borderWidth = 1
            
            //creating uitextfield for chord label in uiview
            var txtField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width:95.00, height: 40.00));
            var chordlabel = updateLabel()
            txtField.text = chordlabel
            txtField.font = UIFont(name: "KohinoorDevanagari-Light", size: 15)
            chordView.addSubview(txtField)
            
            //add chordView to ProgScrollView
            ProgScrollView.addSubview(chordView)
            left += width;
            width = 100.0
        }
    }
    
    @IBAction func DeleteChord(sender: UIButton) {
        //delete last touched chord and shift all views over
        //for subview in view {}.. look at uitouch timestamp
        
    }
    
    @IBAction func ClearAll(sender: UIButton) {
        for subview in ProgScrollView.subviews{
            subview.removeFromSuperview()
        }
        left = 0
    }
    
    

}
