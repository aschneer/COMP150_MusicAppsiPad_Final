//
//  PlayArea.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 4/7/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class PlayArea: UIView {
    var firstTimeThrough: Bool = true

    let windowWidth: CGFloat = 684
    let windowHeight: CGFloat = 530
    var playableNotes: [Int] = []
    var spacing: CGFloat = 0
    var frequency: CGFloat = 0.02
    
    struct Line {
        var note: Int
        var top: CGFloat
        var middle: CGFloat
        var bottom: CGFloat
        var touched: Bool
        var label: UILabel
        var sineCounter: CGFloat
    }
    
    var lines: [Line] = []
    var linesInitialized: Bool = false
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        
        if !linesInitialized {
            println(playableNotes.count)
            
            spacing = windowHeight / CGFloat(playableNotes.count + 1)
        
            var startingPoint: CGFloat = spacing
            CGContextMoveToPoint(context, 50, startingPoint)
            
            for note in playableNotes {
                var label = UILabel(frame: CGRectMake(5, startingPoint, 50, 50))
                label.center = CGPointMake(25, startingPoint)
                label.text = getNoteName(note)
                label.textAlignment = .Center
                self.addSubview(label)
                
                var newLine = Line(note: note, top: startingPoint - (spacing / 2), middle: startingPoint, bottom: startingPoint + (spacing / 2), touched: false, label: label, sineCounter: 50.0)
                lines.append(newLine)
            
                CGContextAddLineToPoint(context, windowWidth, startingPoint)
                CGContextStrokePath(context)
                startingPoint = spacing + startingPoint
                CGContextMoveToPoint(context, 50, startingPoint)
            }
            
            linesInitialized = true
            
            if firstTimeThrough {
                // Add a notification center to receive notes
                var center = NSNotificationCenter.defaultCenter()
                center.addObserver(self, selector: "receiveNotes:", name: "playableNotes", object: nil)
                center.addObserver(self, selector: "setFreq:", name: "setFreq", object: nil)
                
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "drawLines:", userInfo: nil, repeats: true)
                
                PdBase.addToSearchPath(NSBundle.mainBundle().resourcePath)
                PdExternals.setup()
                
                var patch = PdBase.openFile("main.pd", path: (NSBundle.mainBundle().resourcePath! + "/"))
                
                firstTimeThrough = false
            }
        } else {
            var numLines = lines.count
            for var i = 0; i < numLines; i++ {
                CGContextMoveToPoint(context, 50, lines[i].middle)
                if lines[i].touched {
                    for var j = 50; j < Int(windowWidth); j += 5 {
                        CGContextAddLineToPoint(context, CGFloat(j), CGFloat(10 * sin((CGFloat(j - 50) + lines[i].sineCounter) * frequency)) + lines[i].middle)
                        CGContextStrokePath(context)
                        CGContextMoveToPoint(context, CGFloat(j), CGFloat(10 * sin((CGFloat(j - 50) + lines[i].sineCounter) * frequency)) + lines[i].middle)
                        
                    }
                    lines[i].sineCounter += 5.0
                } else {
                    CGContextAddLineToPoint(context, windowWidth, lines[i].middle)
                    CGContextStrokePath(context)
                }
            }
        }
    }
    
    func drawLines(timer: NSTimer) {
        setNeedsDisplay()
    }
    
    func getNoteName(note: Int) -> String {
        var noteNumber = note % 12
        
        switch noteNumber {
        case 0: return "C"
        case 1: return "C♯/D♭"
        case 2: return "D"
        case 3: return "D♯/E♭"
        case 4: return "E"
        case 5: return "F"
        case 6: return "F♯/G♭"
        case 7: return "G"
        case 8: return "G♯/A♭"
        case 9: return "A"
        case 10: return "A♯/B♭"
        case 11: return "B"
            
        default: return "Q"
        }
    }
    
    func receiveNotes(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<String, [Int]> {
            for line in lines {
                line.label.removeFromSuperview()
            }
            lines = []
            playableNotes = info["notes"]!
            
            linesInitialized = false
        }
    }
    
    func setFreq(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<String, CGFloat> {
            frequency = info["freq"]! + 0.01
        }
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.first as! UITouch
        let tapCount = touch.tapCount
        
        let point = touch.locationInView(self)
        var note = -1
        
        var counter = 0
        for line in lines {
            if point.y >= line.top && point.y <= line.bottom && point.x <= windowWidth{
                note = line.note
                lines[counter].touched = true
                
                // 1, piano = 1 guitar = 2, midi num, velocity 0 or 1, a 600, d 1000, s .1, r 3000, 1
                PdBase.sendList([1, 2, lines[counter].note, 1, 600, 1000, 0.1, 3000, 0], toReceiver: "note_msg")
                
                break
            }
            counter++
        }
        
        if note != -1 {
            //println("Touch at MIDI " + String(note))
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.first as! UITouch
        let tapCount = touch.tapCount
        
        let yValue = touch.locationInView(self).y
        var note = -1
        
        var counter = 0
        for line in lines {
            if yValue >= line.top && yValue <= line.bottom {
                note = line.note
            }
            
            lines[counter].touched = false
            
            // 1, piano = 1 guitar = 2, midi num, velocity 0 or 1, a 600, d 1000, s .1, r 3000, 1
            PdBase.sendList([1, 2, lines[counter].note, 0, 600, 1000, 0.1, 3000, 0], toReceiver: "note_msg")
            
            counter++
        }
        
        
        var allTouches = event.allTouches()
        
        for singleTouch in allTouches! {
            var touchYValue = (singleTouch as! UITouch).locationInView(self).y
        
            counter = 0
            
            for line in lines {
                if touchYValue >= line.top && touchYValue <= line.bottom {
                    lines[counter].touched = true
                    
                    // 1, piano = 1 guitar = 2, midi num, velocity 0 or 1, a 600, d 1000, s .1, r 3000, 1
                    PdBase.sendList([1, 2, lines[counter].note, 1, 600, 1000, 0.1, 3000, 0], toReceiver: "note_msg")
                    
                }
                counter++
            }
        }
        
        if note != -1 {
//            println("Touch moved at MIDI " + String(note))
//            
//            for line in lines {
//                print(line.touched)
//                print(" ")
//            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.first as! UITouch
        let tapCount = touch.tapCount
        
        let yValue = touch.locationInView(self).y
        var note = -1
        
        var counter = 0
        for line in lines {
            if yValue >= line.top && yValue <= line.bottom {
                note = line.note
                lines[counter].touched = false
                
                // 1, piano = 1 guitar = 2, midi num, velocity 0 or 1, a 600, d 1000, s .1, r 3000, 1
                PdBase.sendList([1, 2, lines[counter].note, 0, 600, 1000, 0.1, 3000, 0], toReceiver: "note_msg")
                break
            }
            counter++
        }
        
        if note != -1 {
//            println("Touch ended at MIDI " + String(note))
//            
//            for line in lines {
//                print(line.touched)
//                print(" ")
//            }
        }
    }
}
