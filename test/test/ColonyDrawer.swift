//
//  colonyDrawer.swift
//  IosGameOfLife
//
//  Created by daniel bauman on 11/22/16.
//
//

import UIKit

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero
}

class ColonyDrawer: UIView {
    
    var minX,minY,maxX,maxY,height,width: CGFloat?
    
    var viewController: DetailViewController?
    
    func strokeLine(line: Line) {
        let path = UIBezierPath()
        path.lineWidth = 3
        path.lineCapStyle = CGLineCap.Round
        path.moveToPoint(line.begin)
        path.addLineToPoint(line.end)
        path.stroke()
    }
    
    func makeTable() {
        let ctx = UIGraphicsGetCurrentContext()
        for x in 0..<60 {
            for y in 0..<60 {
                let currentMinX = self.minX! + CGFloat(x)*self.width!
                let currentMinY = self.minY! + CGFloat(y)*self.height!
                let rectangle = CGRectMake(currentMinX, currentMinY, self.width!, self.height!)
                CGContextBeginPath(ctx)
                CGContextAddRect(ctx, rectangle)
                CGContextSetLineWidth(ctx, 1)
                CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
                CGContextStrokePath(ctx)
            }
        }
    }
    
    func findBounds() {
        
        minX = self.bounds.minX
        minY = self.bounds.minY
        maxX = self.bounds.maxX
        maxY = self.bounds.maxY
        width = CGFloat(Int(self.bounds.width)/60)
        height = CGFloat(Int(self.bounds.height)/60)
    }
    
    func drawRectangle() {
        findBounds()
        let ctx = UIGraphicsGetCurrentContext()
        for x in 0..<60 {
            for y in 0..<60 {
                let currentMinX = self.minX! + CGFloat(x)*self.width!
                let currentMinY = self.minY! + CGFloat(y)*self.height!
                let rectangle = CGRectMake(currentMinX, currentMinY, self.width!, self.height!)
                CGContextBeginPath(ctx)
                CGContextAddRect(ctx, rectangle)
                CGContextSetLineWidth(ctx, 1)
                CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
                CGContextStrokePath(ctx)
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawRectangle()
    }
}


