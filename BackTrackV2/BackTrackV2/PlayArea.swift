//
//  PlayArea.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 4/7/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class PlayArea: UIView {

    let windowWidth: CGFloat = 684
    let windowHeight: CGFloat = 530
    var playableNotes = [76, 74, 72, 71, 69, 67, 65, 64, 62, 60]
    var spacing: CGFloat = 0
    
    struct Line {
        var note: Int
        var top: CGFloat
        var middle: CGFloat
        var bottom: CGFloat
        var touched: Bool
    }
    
    var lines: [Line] = []
    var linesInitialized: Bool = false
    
    var sineCounter: CGFloat = 0
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        
        if !linesInitialized {
            spacing = windowHeight / CGFloat(playableNotes.count + 1)
        
            var startingPoint: CGFloat = spacing
            CGContextMoveToPoint(context, 0, startingPoint)
            
            for note in playableNotes {
                var newLine = Line(note: note, top: startingPoint - (spacing / 2), middle: startingPoint, bottom: startingPoint + (spacing / 2), touched: false)
                lines.append(newLine)
            
                CGContextAddLineToPoint(context, windowWidth, startingPoint)
                CGContextStrokePath(context)
                startingPoint = spacing + startingPoint
                CGContextMoveToPoint(context, 0, startingPoint)
            }
            
            linesInitialized = true
        
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "drawLines:", userInfo: nil, repeats: true)
        } else {
            for line in lines {
                CGContextMoveToPoint(context, 0, line.middle)
                if line.touched {
                    for var i = 0; i < Int(windowWidth); i += 5 {
                        CGContextAddLineToPoint(context, CGFloat(i), CGFloat(10 * sin((CGFloat(i) + sineCounter) * 0.02)) + line.middle)
                        CGContextStrokePath(context)
                        CGContextMoveToPoint(context, CGFloat(i), CGFloat(10 * sin((CGFloat(i) + sineCounter) * 0.02)) + line.middle)
                        
                    }
                } else {
                    CGContextAddLineToPoint(context, windowWidth, line.middle)
                    CGContextStrokePath(context)
                }
                
                sineCounter += 1.0
            }
        }
    }
    
    func drawLines(timer: NSTimer) {
        setNeedsDisplay()
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.anyObject() as UITouch
        let tapCount = touch.tapCount
        
        let yValue = touch.locationInView(self).y
        var note = -1
        
        var counter = 0
        for line in lines {
            if yValue >= line.top && yValue <= line.bottom {
                note = line.note
                lines[counter].touched = true
                break
            }
            counter++
        }
        
        if note != -1 {
            //println("Touch at MIDI " + String(note))
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.anyObject() as UITouch
        let tapCount = touch.tapCount
        
        let yValue = touch.locationInView(self).y
        var note = -1
        
        var counter = 0
        for line in lines {
            if yValue >= line.top && yValue <= line.bottom {
                note = line.note
            }
            
            lines[counter].touched = false
            
            counter++
        }
        
        
        var allTouches = event.allTouches()
        
        for singleTouch in allTouches! {
            var touchYValue = singleTouch.locationInView(self).y
        
            counter = 0
            
            for line in lines {
                if touchYValue >= line.top && touchYValue <= line.bottom {
                    lines[counter].touched = true
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
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.anyObject() as UITouch
        let tapCount = touch.tapCount
        
        let yValue = touch.locationInView(self).y
        var note = -1
        
        var counter = 0
        for line in lines {
            if yValue >= line.top && yValue <= line.bottom {
                note = line.note
                lines[counter].touched = false
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
