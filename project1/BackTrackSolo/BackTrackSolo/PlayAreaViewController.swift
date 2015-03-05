//
//  PlayAreaViewController.swift
//  BackTrackSolo
//
//  Created by Jacob Apkon on 2/28/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class PlayAreaViewController: UIViewController, UIGestureRecognizerDelegate {

    let pieLayer = PieLayer()
    
    struct notes {
        var midiValue : Int
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        gesture.delegate = self
        return gesture
    }()
    
    private func addGestures() {
        self.view.addGestureRecognizer(self.tapGesture)
    }
    
    var noteArray : [notes] = []
    var numNotes : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "receiveNotes:", name: "playableNotes", object: nil)
        self.addGestures()
    }

    deinit {
        var center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }
    
    func receiveNotes(notification: NSNotification){
        if let info = notification.userInfo as? Dictionary<String, [Int]> {
            var noteArray = info["notes"]
            numNotes = noteArray!.count
            
            view.layer.addSublayer(pieLayer)
            pieLayer.setMaxRadius(200, minRadius: 50, animated: true)
            pieLayer.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
            
            for var i = 0; i < numNotes; i++ {
                pieLayer.addValues([PieElement(value: 1, color: randomColor(noteArray![i]))], animated: true)
            }
        }
    }
    
    func randomColor(blue: Int) -> UIColor {
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(blue) / 100
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.75)
    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        var center = NSNotificationCenter.defaultCenter()
        
        var pos: CGPoint = tap.locationInView(tap.view)
        
        var tappedSlice: PieElement? = self.pieLayer.pieElemInPoint(pos)
        
        if let actualSlice = tappedSlice {
            var midinote = CGColorGetComponents(actualSlice.color.CGColor)[2] * 100
            var slice_color = CGColorGetComponents(actualSlice.color.CGColor)
            actualSlice.color = UIColor(red: slice_color[0], green: slice_color[1], blue: slice_color[2], alpha: 1)
        
            center.postNotificationName("noteToPlay", object: nil, userInfo: ["play": midinote])
        
            if tap.state == UIGestureRecognizerState.Ended {
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "fadeOutSlice:", userInfo: ["slice": actualSlice], repeats: false)
            }
        }
    }
    
    func fadeOutSlice(timer: NSTimer) {
        var center = NSNotificationCenter.defaultCenter()

        if let info = timer.userInfo as? Dictionary<String, PieElement> {
            var slice = info["slice"]
            
            var midinote = CGColorGetComponents(slice!.color.CGColor)[2] * 100
            
            var slice_color = CGColorGetComponents(slice!.color.CGColor)
            slice!.color = UIColor(red: slice_color[0], green: slice_color[1], blue: slice_color[2], alpha: 0.75)
            center.postNotificationName("stopNote", object: nil, userInfo: ["stop": midinote])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
