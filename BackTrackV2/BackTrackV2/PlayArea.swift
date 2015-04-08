//
//  PlayArea.swift
//  BackTrackV2
//
//  Created by Jacob Apkon on 4/7/15.
//  Copyright (c) 2015 COMP150. All rights reserved.
//

import UIKit

class PlayArea: UIView, UIGestureRecognizerDelegate {

    var playableNotes = [60, 62, 64, 65, 67, 69, 71, 72]
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let components: [CGFloat] = [0.0, 0.0, 0.0, 1.0]
        let color = CGColorCreate(colorSpace, components)
        CGContextSetStrokeColorWithColor(context, color)
        let spacing: CGFloat = 530 / CGFloat(playableNotes.count + 1)
        
        var startingPoint: CGFloat = spacing
        CGContextMoveToPoint(context, 75, startingPoint)
        
        for note in playableNotes {
            CGContextAddLineToPoint(context, 609, startingPoint)
            CGContextStrokePath(context)
            startingPoint = spacing + startingPoint
            CGContextMoveToPoint(context, 75, startingPoint)
        }
        
        addGestureRecognizer(self.tapGesture)
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        gesture.delegate = self
        return gesture
    }()
    
    func handleTap(tap: UITapGestureRecognizer) {
        println(tap.locationInView(self))
    }
}
