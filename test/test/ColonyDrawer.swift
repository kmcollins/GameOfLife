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
    
    override func drawRect(rect: CGRect) {
        let width = self.bounds.width/60
        let height = self.bounds.height/60
        for x in 0..<60 {
            for y in 0..<60 {
                let currentMinX = self.bounds.minX + CGFloat(x)*width
                let currentMinY = self.bounds.minY + CGFloat(y)*height
                let rectangle = CGRectMake(currentMinX, currentMinY, width, height)
                let path = UIBezierPath(rect: rectangle)
                UIColor.blackColor().setStroke()
                path.lineWidth = 1
                path.stroke()
                if self.currentColony != nil {
                    if self.currentColony!.cells.contains(Coordinate(x: x, y: y)) {
                        UIColor.blackColor().setFill()
                        path.fill()
                    }
                }
            }
        }
    }
}


