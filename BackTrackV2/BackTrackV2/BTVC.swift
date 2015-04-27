//
//  BTVC.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 3/27/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class BTVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
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
    
    @IBOutlet weak var ChordPicker: UIPickerView!
    let pickerData = [
        ["12", "16"],
        ["Swing", "Blues", "Latin", "Jazz", "Rock"],
        ["A", "B", "C", "D", "E", "F", "G"],
        ["♮", "♯", "♭"],
        ["Maj", "Min", "Aug", "Dim"],
        ["Triad", "7", "Maj7"]
    ]
    
    struct Beat {
        var piano: [Int]
        var drums: [Int]
        var bass: Int
    }
    

    var beats: [Beat] = []//16th notes in bars we're creating

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProgScrollView.contentSize = CGSizeMake(1600, 128)
        ProgScrollView.userInteractionEnabled = true
        initLoadBars()
        
        ChordPicker.dataSource = self
        ChordPicker.delegate = self
        ChordPicker.backgroundColor = UIColor(red: 170/255, green: 57/255, blue: 57/255, alpha: 1.0)
        ChordPicker.layer.cornerRadius = 15
        ChordPicker.layer.borderColor = UIColor.blackColor().CGColor
        ChordPicker.layer.borderWidth = 5
        selectedChord.textAlignment = .Center
        
        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "play:", name: "playBackingTrack", object: nil)
        center.addObserver(self, selector: "pause:", name: "pauseBackingTrack", object: nil)
        center.addObserver(self, selector: "stop:", name: "stopBackingTrack", object: nil)
    }
    
    
    var playing: Int = 0
    func play(notification: NSNotification) {
        playing = 2
    }

    func pause(notification: NSNotification) {
        playing = 1
    }
    
    func stop(notification: NSNotification) {
        playing = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    var iterator: Int = 0
    var sfpath = NSBundle.mainBundle().resourcePath! + "/piano_1.sf2"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.125, target: self, selector: "playBackingTrack:", userInfo: nil, repeats: true)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func playBackingTrack(timer: NSTimer) {
        switch playing {
        case 0: iterator = 0
        case 1: return
        case 2: var index = iterator % beats.count
            for note in beats[index].piano {
                PdBase.sendList([1, sfpath, note, 127, 600, 1000, 0.1, 3000, 0], toReceiver: "note_msg")
            }
            iterator++
        
        default: var index = iterator % beats.count
            for note in beats[index].piano {
                PdBase.sendList([1, sfpath, note, 127, 600, 1000, 0.1, 3000, 0], toReceiver: "note_msg")
            }
            iterator++
        }
    }

    
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
        return 75
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
        if pickerData[0][ChordPicker.selectedRowInComponent(0)] != String(chords.count) {
            updateNumBars()
        }
        
    }
    
    func updateLabel() -> String {
        var root = pickerData[2][ChordPicker.selectedRowInComponent(2)]
        var sharpOrFlat = pickerData[3][ChordPicker.selectedRowInComponent(3)]
        var majOrMin = pickerData[4][ChordPicker.selectedRowInComponent(4)]
        var chord = pickerData[5][ChordPicker.selectedRowInComponent(5)]
        
        var label = root
        
        if sharpOrFlat != "♮" {
            label += sharpOrFlat
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
        return label
    }
    
    func updateNumBars() {
        var numBars = pickerData[0][ChordPicker.selectedRowInComponent(0)]
        if numBars == "16" {
            for i in 0...3 {
                var chordView = UIButton(frame: CGRectMake(CGFloat(left), CGFloat(top), CGFloat(width), CGFloat(height)))
                chordView.backgroundColor = UIColor.whiteColor()
                chordView.layer.borderColor = UIColor.blackColor().CGColor
                chordView.layer.borderWidth = 1
                
                chordView.addTarget(self, action: "barPressed:", forControlEvents: .TouchUpInside)
                
                ProgScrollView.addSubview(chordView)
                left += width
                
                chords.append(chordView)
            }
            
        } else {
            for i in 0...3 {
                var lastBar = chords.removeLast()
                lastBar.removeFromSuperview()
                left -= width
            }
        }
        
    }
    
    /*
    @IBAction func ClearAll(sender: UIButton) {
        for subview in ProgScrollView.subviews{
            subview.removeFromSuperview()
        }
        left = 0
    }
    */
    
    var top = 0.0
    var left = 0.0
    var width = 100.0
    var height = 128.0
    
    var chords: [UIButton] = []//what the user is creating
    
    func initLoadBars() {
        for i in 0...11 {
            var chordView = UIButton(frame: CGRectMake(CGFloat(left), CGFloat(top), CGFloat(width), CGFloat(height)))
            chordView.backgroundColor = UIColor.whiteColor()
            chordView.layer.borderColor = UIColor.blackColor().CGColor
            chordView.layer.borderWidth = 1
            
            chordView.addTarget(self, action: "barPressed:", forControlEvents: .TouchUpInside)
            
            ProgScrollView.addSubview(chordView)
            left += width;
            
            chords.append(chordView)
        }
        
        for i in 0...(12 * 16) {
            beats.append(Beat(piano: [], drums: [], bass: 0))
        }
    }
    
    func barPressed(sender: UIButton!) {
        sender.backgroundColor = UIColor.greenColor()
        var index = (find(chords, sender)! * 12)
        
        var root = 0
        switch pickerData[2][ChordPicker.selectedRowInComponent(2)] {
        case "A": root = 57
        case "B": root = 59
        case "C": root = 60
        case "D": root = 62
        case "E": root = 64
        case "F": root = 65
        case "G": root = 67
            
        default: root = 0
        }
        
        switch pickerData[3][ChordPicker.selectedRowInComponent(3)] {
        case "♮": break
        case "♯": root++
        case "♭": root--
            
        default: break
        }
        
        var third = root + 4
        var fifth = root + 7
        
        beats[index].piano.append(root)

        var chordType = pickerData[4][ChordPicker.selectedRowInComponent(4)]
        
        if chordType == "Min" { third-- }
        if chordType == "Aug" { fifth++ }
        if chordType == "Dim" { third--; fifth-- }
        
        beats[index].piano.append(third)
        beats[index].piano.append(fifth)
        
        var higherNotes = pickerData[5][ChordPicker.selectedRowInComponent(5)]

        if higherNotes == "Triad" { return }
        if higherNotes == "7" { beats[index].piano.append(root + 10) }
        if higherNotes == "Maj7" { beats[index].piano.append(root + 11) }
        
    }

}
