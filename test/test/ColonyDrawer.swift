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
    var makingAlive: Bool = false
    var secondColony: Colony?
    var coordinateLabel: UILabel?
    
    var cellSide: CGFloat {
        var colonyWidth = 60
        var colonyHeight = 60
        if let colony = currentColony {
            colonyHeight = colony.yMax
            colonyWidth = colony.xMax
        }
        if let secondcol = secondColony {
            if secondcol.yMax > colonyHeight {
                colonyHeight = secondcol.yMax
            }
            if secondcol.xMax > colonyWidth {
                colonyWidth = secondcol.xMax
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
            let additionValue = (self.bounds.height - self.bounds.width)/2 //center vertically
            return CGRectMake(self.bounds.minX, self.bounds.minY+additionValue, self.bounds.width, self.bounds.width)
        } else { //use height
            let additionValue = (self.bounds.width - self.bounds.height)/2//center horizontally
            return CGRectMake(self.bounds.minX+additionValue, self.bounds.minY, self.bounds.height, self.bounds.height)
        }
    }
    
    override func drawRect(rect: CGRect) {
        for x in 0..<Int(self.viewBounds.width/self.cellSide) { //number of cells horizontally
            for y in 0..<Int(self.viewBounds.height/self.cellSide) { //number of cells vertically
                let rectangle = colonyCoordinateToViewCoordinate(x, y: y)
                let path = UIBezierPath(rect: rectangle)
                UIColor.blackColor().setStroke()
                path.lineWidth = 0.5
                path.stroke()
                if let colony = self.currentColony {
                    if let col2 = self.secondColony {
                        if col2.cells.contains(Coordinate(x: x, y: y)) && colony.cells.contains(Coordinate(x: x, y: y)) {
                            UIColor.purpleColor().setFill()
                            path.fill()
                        }
                        else if col2.cells.contains(Coordinate(x: x, y: y)) {
                            UIColor.redColor().setFill()
                            path.fill()
                        }
                        else if colony.cells.contains(Coordinate(x: x, y: y)) {
                            UIColor.blueColor().setFill()
                            path.fill()
                        }
                    }
                    else if colony.cells.contains(Coordinate(x: x, y: y)) {
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
        let cell = viewCoordinateToColonyCoordinate(touches.first!.locationInView(self))
        if let colony = currentColony {
            if cell.x < colony.xMax && cell.y < colony.yMax && cell.y >= 0 && cell.x >= 0 {
                if colony.cells.contains(cell) {
                    self.makingAlive = false
                    colony.setCellDead(cell.x, yCoor: cell.y)
                } else {
                    self.makingAlive = true
                    colony.setCellAlive(cell.x, yCoor: cell.y)
                }
            }
            if let coorLabel = coordinateLabel {
                coorLabel.text = "(\(cell.x),\(cell.y))"
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let cell = viewCoordinateToColonyCoordinate(touches.first!.locationInView(self))
        if let colony = currentColony {
            if cell.x < colony.xMax && cell.y < colony.yMax && cell.y >= 0 && cell.x >= 0 {
                if makingAlive {
                    colony.setCellAlive(cell.x, yCoor: cell.y)
                } else {
                    colony.setCellDead(cell.x, yCoor: cell.y)
                }
            }
            if let coorLabel = coordinateLabel {
                coorLabel.text = "(\(cell.x),\(cell.y))"
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let cell = viewCoordinateToColonyCoordinate(touches.first!.locationInView(self))
        if let colony = currentColony {
            if cell.x < colony.xMax && cell.y < colony.yMax && cell.y >= 0 && cell.x >= 0 {
                if makingAlive {
                    colony.setCellAlive(cell.x, yCoor: cell.y)
                } else {
                    colony.setCellDead(cell.x, yCoor: cell.y)
                }
                
                if let coorLabel = coordinateLabel {
                    coorLabel.text = "(x,y)"
                }
            }
            
        }
        setNeedsDisplay()
    }
    
}


