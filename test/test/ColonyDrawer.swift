//
//  colonyDrawer.swift
//  IosGameOfLife
//
//  Created by daniel bauman on 11/22/16.
//
//

import UIKit

class ColonyDrawer: UIView {
    
    var currentColony: Colony?
    var onTouching: Bool?
    var makingAlive: Bool?
    var secondColony: Colony?
    
    var sideSize: CGFloat {
        var colonyHeight = 60
        var colonyWidth = 60
        if self.currentColony != nil {
            colonyWidth = self.currentColony!.xMax
            colonyHeight = self.currentColony!.yMax
        }
        let height = self.bounds.height/CGFloat(colonyHeight)
        let width = self.bounds.width/CGFloat(colonyWidth)
        if height >= width {
            return width
        }
        return height
    }
    
    override func drawRect(rect: CGRect) {
        var colonyHeight = 60
        var colonyWidth = 60
        if self.currentColony != nil {
            colonyWidth = self.currentColony!.xMax
            colonyHeight = self.currentColony!.yMax
        }
        for x in 0..<colonyWidth {
            for y in 0..<colonyHeight {
                let rectangle = colonyCoordinateToViewCoordinate(x, y: y)
                let path = UIBezierPath(rect: rectangle)
                UIColor.blackColor().setStroke()
                path.lineWidth = 0.5
                path.stroke()
                if self.currentColony != nil {
                    if let col2 = self.secondColony {
                        if col2.cells.contains(Coordinate(x: x, y: y)) && self.currentColony!.cells.contains(Coordinate(x: x, y: y)) {
                            UIColor.purpleColor().setFill()
                            path.fill()
                        }
                        else if col2.cells.contains(Coordinate(x: x, y: y)) {
                            UIColor.redColor().setFill()
                            path.fill()
                        }
                        else if self.currentColony!.cells.contains(Coordinate(x: x, y: y)) {
                            UIColor.blueColor().setFill()
                            path.fill()
                        }
                    }
                    else if self.currentColony!.cells.contains(Coordinate(x: x, y: y)) {
                        UIColor.blueColor().setFill()
                        path.fill()
                    }
                    
                }
            }
        }
    }
    
    func colonyCoordinateToViewCoordinate(x: Int, y: Int)-> CGRect {
        return CGRectMake(self.bounds.minX+CGFloat(x)*self.sideSize, self.bounds.minY+CGFloat(y)*self.sideSize, self.sideSize, self.sideSize)
    }
    
    func viewCoordinateToColonyCoordinate(point: CGPoint)->Coordinate {
        return Coordinate(x: Int(point.x/self.sideSize), y: Int(point.y/self.sideSize))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        let cell = viewCoordinateToColonyCoordinate(location)
        if currentColony != nil {
            self.onTouching = true
            if currentColony!.cells.contains(cell) {
                self.makingAlive = false
                currentColony!.setCellDead(cell.getX(), yCoor: cell.getY())
            } else {
                self.makingAlive = true
                currentColony!.setCellAlive(cell.getX(), yCoor: cell.getY())
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        let cell = viewCoordinateToColonyCoordinate(location)
        if currentColony != nil {
            if (self.makingAlive != nil) {
                if self.makingAlive! {
                    currentColony!.setCellAlive(cell.getX(), yCoor: cell.getY())
                } else {
                    currentColony!.setCellDead(cell.getX(), yCoor: cell.getY())
                }
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        let cell = viewCoordinateToColonyCoordinate(location)
        if currentColony != nil {
            self.onTouching = false
            if (self.makingAlive != nil) {
                if self.makingAlive! {
                    currentColony!.setCellAlive(cell.getX(), yCoor: cell.getY())
                } else {
                    currentColony!.setCellDead(cell.getX(), yCoor: cell.getY())
                }
            }
        }
        setNeedsDisplay()
    }
}


