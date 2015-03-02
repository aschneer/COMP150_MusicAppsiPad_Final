//
//  PlayAreaViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/28/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class PlayAreaViewController: UIViewController {

    struct notes {
        var midiValue : Int
        
    }
    var noteArray : [notes] = []
    var numNotes : Int = 0
    
    @IBOutlet var noteArea: XYPieChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "receiveNotes:", name: "playableNotes", object: nil)
    }

    deinit {
        var center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }
    
    func receiveNotes(notification: NSNotification){
        if let info = notification.userInfo as? Dictionary<String, [Int]> {
            var noteArray = info["notes"]
            numNotes = noteArray!.count
            println(numNotes)
            println(noteArray!)
        }
    }
    
    func numberOfSlicesInPieChart(pieChart: XYPieChart) -> UInt {
        return UInt(noteArray.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
