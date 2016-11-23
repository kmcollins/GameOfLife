//
//  Colony.swift
//  GameOfLife
//
//  Created by Katie Collins on 9/26/16.
//  Copyright © 2016 CollinsInnovation. All rights reserved.
//

import Foundation

class Colony: CustomStringConvertible{
    
    var cells: Set<Coordinate> = []
    
    var genNumber: Int = 0
    
    let yMax = 80
    let xMax = 80
    var wrapping: Bool = false
    
    func setCellAlive(xCoor: Int, yCoor: Int) {
        if xCoor < xMax && xCoor >= 0 {
            if yCoor < yMax && yCoor >= 0 {
                let coor = Coordinate(x: xCoor, y: yCoor)
                cells.insert(coor)
            }
        }
    }
    
    func setCellDead(xCoor: Int, yCoor: Int) {
        let coor = Coordinate(x: xCoor, y: yCoor)
        cells.remove(coor)
    }
    
    func resetColony() {
        cells.removeAll()
    }
    
    func isCellAlive(xCoor:Int, yCoor: Int) -> Bool{
        for c in cells {
            if c.getX() == xCoor && c.getY() == yCoor {
                return true
            }
        }
        return false
    }
    
    func wrap(x: Int, y: Int)-> Coordinate { // a function that converts all cells that exceed the borders to be inside the opposite border(wrapping)
        var newX = x
        var newY = y
        if x == -1 {
            newX = xMax-1
        }
        if x == xMax {
            newX = 0
        }
        if y == -1 {
            newY = yMax-1
        }
        if y == yMax {
            newY = 0
        }
        return Coordinate(x: newX, y: newY)
    }
    
    func getNeighbors(x: Int, y: Int) -> Set<Coordinate> {
        var neighbors: Set <Coordinate> = [];
        neighbors.insert(Coordinate(x: x + 1, y: y));
        neighbors.insert(Coordinate(x: x - 1, y: y));
        neighbors.insert(Coordinate(x: x, y: y + 1));
        neighbors.insert(Coordinate(x: x, y: y - 1));
        neighbors.insert(Coordinate(x: x + 1, y: y + 1));
        neighbors.insert(Coordinate(x: x - 1, y: y - 1));
        neighbors.insert(Coordinate(x: x + 1, y: y - 1));
        neighbors.insert(Coordinate(x: x - 1, y: y + 1));
        if wrapping { //converts all cells to wrapped form
            neighbors = Set(neighbors.map({wrap($0.getX(), y: $0.getY())}))
        }
        return neighbors;
    }
    
    func evolve() {
        
        genNumber += 1
        
        var newCells: Set<Coordinate> = []
        var toCheck: Set<Coordinate> = []
        var temp: Set<Coordinate> = []
        
        // Populating toCheck with the cells toCheck
        let _ = cells.map({
            let _ = getNeighbors($0.x, y: $0.y).map(
                {t in toCheck.insert(t)})
            toCheck.insert($0)
        })
        temp.removeAll()
        
        // Count the number of neighbors in the set for each coordinate and apply rules
        
        let _ = toCheck.map(
            {var alive = 0
                let _ = getNeighbors($0.x, y: $0.y).map(
                    {t in if cells.contains(t) {alive += 1}})
                if !cells.contains($0) {
                    // Was not originally alive
                    if alive == 3 {
                        newCells.insert($0);
                    }
                }
                else {
                    if alive == 3 || alive == 2 {
                        newCells.insert($0);
                    }
                }
            }
        )
        
        // Convert the newCells to the actual cells
        
        cells.removeAll();
        let _ = newCells.map({setCellAlive($0.x, yCoor: $0.y)})
        
    }
    
    func coorString(x: Int, y: Int) -> String {
        if isCellAlive(x, yCoor: y) {
            return "*"
        } else {
            return " "
        }
    }
    
    func useWrapping(){
        self.wrapping = true
    }
    
    func dontUseWrapping(){
        self.wrapping = false
    }
    
    var description: String {
        var output = ""
        output += "Generation #" + String(genNumber) + "\n\n"
        for x in 0 ..< xMax {
            for y in 0 ..< yMax {
                output += coorString(x, y: y)
            }
            output += "\n"
        }
        return output
    }
}
