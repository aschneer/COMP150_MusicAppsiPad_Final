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
    
    private var pieInitialized : Bool = false
    
    struct notes {
        var midiValue : Int
    }
    
    var slicePlaying : PieElement?
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        gesture.delegate = self
        return gesture
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        gesture.delegate = self
        return gesture
    }()
    
    /*private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        gesture.delegate = self
        return gesture
    }()*/
    
    private func addGestures() {
        self.view.addGestureRecognizer(self.tapGesture)
        self.view.addGestureRecognizer(self.panGesture)
        //self.view.addGestureRecognizer(self.longPressGesture)
    }
    
    var noteArray : [notes] = []
    var numNotes : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "receiveNotes:", name: "playableNotes", object: nil)
        self.addGestures()
        var bgColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        self.view.backgroundColor = bgColor
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
            
            if pieInitialized {
                var count = pieLayer.values.count
                for var i : Int = count - 1; i >= 0; i-- {
                    pieLayer.deleteValues([pieLayer.values[i]], animated: true)
                }
            }
            
            for var i = 0; i < numNotes; i++ {
                pieLayer.addValues([PieElement(value: 1, color: randomColor(noteArray![i]))], animated: true)
            }
            
            pieInitialized = true
        }
    }
    
    func randomColor(blue: Int) -> UIColor {
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(blue) / 100
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.60)
    }
    
    func handlePan(tap: UIPanGestureRecognizer) {
        var center = NSNotificationCenter.defaultCenter()
        
        var pos: CGPoint = tap.locationInView(tap.view)
        
        var tappedSlice: PieElement? = self.pieLayer.pieElemInPoint(pos)
        
        if tappedSlice != slicePlaying {
            if let actualSlice = tappedSlice {
                var midinote = CGColorGetComponents(actualSlice.color.CGColor)[2] * 100
                var slice_color = CGColorGetComponents(actualSlice.color.CGColor)
                actualSlice.color = UIColor(red: slice_color[0], green: slice_color[1], blue: slice_color[2], alpha: 1)
                
                center.postNotificationName("noteToPlay", object: nil, userInfo: ["play": midinote])
                
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "fadeOutSlice:", userInfo: ["slice": actualSlice], repeats: false)
            }
        }
        
        slicePlaying = tappedSlice
        
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
    
    /*func handleLongPress(tap: UILongPressGestureRecognizer) {
        var center = NSNotificationCenter.defaultCenter()
        
        var pos: CGPoint = tap.locationInView(tap.view)
        
        var tappedSlice: PieElement? = self.pieLayer.pieElemInPoint(pos)
        
        if let actualSlice = tappedSlice {
            var midinote = CGColorGetComponents(actualSlice.color.CGColor)[2] * 100
            var slice_color = CGColorGetComponents(actualSlice.color.CGColor)
            actualSlice.color = UIColor(red: slice_color[0], green: slice_color[1], blue: slice_color[2], alpha: 1)
            
            center.postNotificationName("noteToPlay", object: nil, userInfo: ["play": midinote])
            center.postNotificationName("tremolo", object: nil, userInfo: ["tremolo": 1])
            
            if tap.state == UIGestureRecognizerState.Ended  || tap.state == UIGestureRecognizerState.Cancelled || tap.state == UIGestureRecognizerState.Failed {
                center.postNotificationName("tremolo", object: nil, userInfo: ["tremolo": 0])
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "fadeOutSlice:", userInfo: ["slice": actualSlice], repeats: false)
            }
        }
    }*/
    
    func fadeOutSlice(timer: NSTimer) {
        var center = NSNotificationCenter.defaultCenter()

        if let info = timer.userInfo as? Dictionary<String, PieElement> {
            var slice = info["slice"]
            
            var midinote = CGColorGetComponents(slice!.color.CGColor)[2] * 100
            
            var slice_color = CGColorGetComponents(slice!.color.CGColor)
            slice!.color = UIColor(red: slice_color[0], green: slice_color[1], blue: slice_color[2], alpha: 0.60)
            center.postNotificationName("stopNote", object: nil, userInfo: ["stop": midinote])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
