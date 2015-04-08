//
//  BTVC.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 3/27/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class BTVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var selectedChord: UILabel!
    
    @IBOutlet weak var ChordPicker: UIPickerView!
    let pickerData = [
        ["A", "B", "C", "D", "E", "F", "G"],
        ["♮", "♯", "♭"],
        ["Maj", "Min", "Aug", "Dim"],
        ["Triad", "7", "9"]
    ]
    
    override func viewDidLoad() {
        //println(view.backgroundColor)
        super.viewDidLoad()
        ChordPicker.dataSource = self
        ChordPicker.delegate = self
//        ChordPicker.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ChordPicker.layer.cornerRadius = 15
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
        var pickerLabel = view as UILabel!
        if view == nil {
            pickerLabel = UILabel()
            //let hue = CGFloat(row) / CGFloat(pickerData.count)
            //pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)

        }
        
        let titleData = pickerData[component][row]
        let rowTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName: UIFont(name: "Verdana", size: 24.0)!, NSForegroundColorAttributeName: UIColor.blackColor()])
        pickerLabel!.attributedText = rowTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabel()
    }
    
    func updateLabel() {
        var root = pickerData[0][ChordPicker.selectedRowInComponent(0)]
        var sharpOrFlat = pickerData[1][ChordPicker.selectedRowInComponent(1)]
        var majOrMin = pickerData[2][ChordPicker.selectedRowInComponent(2)]
        var chord = pickerData[3][ChordPicker.selectedRowInComponent(3)]
        
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
        
        selectedChord.text = label
        selectedChord.textAlignment = .Center
    }

}
