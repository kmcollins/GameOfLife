//
//  ColonyHolder.swift
//  IosGameOfLife
//
//  Created by Katie Collins on 11/11/16.
//
//

import Foundation
import UIKit

class ColonyHolder {
    
    var colonies = [Colony]()
    
    func addColony(colonyName: String) {
        let colony = Colony()
        colony.setName(colonyName)
        colony.setCellAlive(29, yCoor: 29)
        colony.setCellAlive(30, yCoor: 29)
        colony.setCellAlive(31, yCoor: 29)
        colony.setCellAlive(30, yCoor: 30)
        colonies.append(colony)
    }
    
    func removeColony(index: Int) {
        colonies.removeAtIndex(index)
    }
    
    func indexOfName(colonyName: String) -> Int? {
        for i in 0..<colonies.count {
            if colonies[i].getName() == colonyName {
                return i 
            }
        }
        return nil
    }
    
    func setCellAliveInColony(index: Int, coordinate: Coordinate)-> Bool {
        if index >= 0 && index < colonies.count {
            colonies[index].setCellAlive(coordinate.getX(), yCoor: coordinate.getY())
            return true
        }
        return false
    }
    
    func setCellDeadInColony(index: Int, coordinate: Coordinate)->Bool {
        if index >= 0 && index < colonies.count {
            colonies[index].setCellDead(coordinate.getX(), yCoor: coordinate.getY())
            return true
        }
        return false
    }
    
    func evolveColony(index: Int)->Bool {
        if index >= 0 && index < colonies.count  {
            colonies[index].evolve()
            return true
        }
        return false
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedCol = colonies[fromIndex]
        
        // Remove colony from array
        colonies.removeAtIndex(fromIndex)
        
        // Insert colony in array at new location
        colonies.insert(movedCol, atIndex: toIndex)
    
    }
    
}
