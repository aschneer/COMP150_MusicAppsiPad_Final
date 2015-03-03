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
            //println(numNotes)
            //println(noteArray!)
            
            pieLayer.frame = CGRectMake(0, 0, 200, 200)
            view.layer.addSublayer(pieLayer)
            
            for var i = 0; i < numNotes; i++ {
                pieLayer.addValues([PieElement(value: 1, color: randomColor())], animated: true)
                println(i)
            }
        }
    }
    
    func randomColor() -> UIColor {
        var randomRed:CGFloat = CGFloat(drand48())
        
        var randomGreen:CGFloat = CGFloat(drand48())
        
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        var pos: CGPoint = tap.locationInView(tap.view)
        var tappedSlice: PieElement = self.pieLayer.pieElemInPoint(pos)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
