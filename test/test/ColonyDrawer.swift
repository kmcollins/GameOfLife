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
    var coordinateLabel: UILabel?
    
    var cellSide: CGFloat {
        var colonyWidth = 60
        var colonyHeight = 60
        if self.currentColony != nil {
            colonyHeight = self.currentColony!.yMax
            colonyWidth = self.currentColony!.xMax
        }
        if self.secondColony != nil {
            if self.secondColony!.yMax > colonyHeight {
                colonyHeight = self.secondColony!.yMax
            }
            if self.secondColony!.xMax > colonyWidth {
                colonyWidth = self.secondColony!.xMax
            }
        }
        var side = colonyHeight
        if colonyWidth > colonyHeight {
            side = colonyWidth
        }
        return self.viewBounds.height/CGFloat(side)
    }
    var viewBounds: CGRect {
        if self.bounds.height >= self.bounds.width { //use width:
            let additionValue = (self.bounds.height - self.bounds.width)/2
            return CGRectMake(self.bounds.minX, self.bounds.minY+additionValue, self.bounds.width, self.bounds.width)
        } else { //use height
            let additionValue = (self.bounds.width - self.bounds.height)/2
            return CGRectMake(self.bounds.minX+additionValue, self.bounds.minY, self.bounds.height, self.bounds.height)
        }
    }
    
    override func drawRect(rect: CGRect) {
        for x in 0..<Int(self.viewBounds.width/self.cellSide) {
            for y in 0..<Int(self.viewBounds.height/self.cellSide) {
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
        return CGRectMake(self.viewBounds.minX+CGFloat(x)*self.cellSide, self.bounds.minY+CGFloat(y)*self.cellSide, self.cellSide, self.cellSide)
    }
    
    func viewCoordinateToColonyCoordinate(point: CGPoint)->Coordinate {
        return Coordinate(x: Int((point.x+(self.bounds.minX-self.viewBounds.minX))/self.cellSide), y: Int((point.y+(self.bounds.minY-self.viewBounds.minY))/self.cellSide))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        let cell = viewCoordinateToColonyCoordinate(location)
        if currentColony != nil {
            if cell.getX() < currentColony!.xMax && cell.getY() < currentColony!.yMax && cell.getY() >= 0 && cell.getX() >= 0 {
                self.onTouching = true
                if currentColony!.cells.contains(cell) {
                    self.makingAlive = false
                    currentColony!.setCellDead(cell.getX(), yCoor: cell.getY())
                } else {
                    self.makingAlive = true
                    currentColony!.setCellAlive(cell.getX(), yCoor: cell.getY())
                }
                if self.coordinateLabel != nil {
                    self.coordinateLabel!.text = "(\(cell.getX()),\(cell.getY()))"
                }
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self)
        let cell = viewCoordinateToColonyCoordinate(location)
        if currentColony != nil {
            if cell.getX() < currentColony!.xMax && cell.getY() < currentColony!.yMax && cell.getX() >= 0 && cell.getY() >= 0{
                if (self.makingAlive != nil) {
                    if self.makingAlive! {
                    currentColony!.setCellAlive(cell.getX(), yCoor:     cell.getY())
                    } else {
                    currentColony!.setCellDead(cell.getX(), yCoor:  cell.getY())
                    }
                }
                if self.coordinateLabel != nil {
                    self.coordinateLabel!.text = "(\(cell.getX()),\(cell.getY()))"
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
            if cell.getX() < currentColony!.xMax && cell.getY() < currentColony!.yMax && cell.getX() >= 0 && cell.getY() >= 0{
                if (self.makingAlive != nil) {
                    if self.makingAlive! {
                        currentColony!.setCellAlive(cell.getX(), yCoor: cell.getY())
                    } else {
                        currentColony!.setCellDead(cell.getX(), yCoor: cell.getY())
                    }
                }
                if self.coordinateLabel != nil {
                    self.coordinateLabel!.text = "(x,y)"
                }
            }
        }
        setNeedsDisplay()
    }
}


