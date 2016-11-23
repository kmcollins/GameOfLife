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
    
    var names = [String]()
    var colonies = [Colony]()
    
    func addColony(colonyName: String) {
        names.append(colonyName)
        colonies.append(Colony())
    }
    
    func removeColony(index: Int) {
        names.removeAtIndex(index)
        colonies.removeAtIndex(index)
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
        
        // Get reference to object being moved so you can reinsert it
        let movedName = names[fromIndex]
        
        // Remove name from array
        names.removeAtIndex(fromIndex)
        
        // Insert name in array at new location
        names.insert(movedName, atIndex: toIndex)
    }
    
    /*
     var allColonies = [String: Colony]()
     // This will be the model --- here will will have methods to add, remove, or move the order of colonies
     
     func addColony(colonyName: String) {
     allColonies[colonyName] = Colony()
     }
     
     func removeColony(colonyName: String) {
     allColonies.removeValueForKey(colonyName)
     }
     
     func setCellAliveInColony(colonyName: String, coordinate: Coordinate)-> Bool {
     if let colony = allColonies[colonyName] {
     colony.setCellAlive(coordinate.getX(), yCoor: coordinate.getY())
     return true
     }
     return false
     }
     
     func setCellDeadInColony(colonyName: String, coordinate: Coordinate)->Bool {
     if let colony = allColonies[colonyName] {
     colony.setCellDead(coordinate.getX(), yCoor: coordinate.getY())
     return true
     }
     return false
     }
     func evolveColony(colonyName: String)->Bool {
     if let colony = allColonies[colonyName] {
     colony.evolve()
     return true
     }
     return false
     }
     
     /*func getColonyForIndex(index: Int) -> Colony? {
     var i = 0
     for v in allColonies.values {
     if i == index { return v }
     i += 1
     }
     return nil
     }
     
     func getNameForIndex(index: Int) -> String? {
     var i = 0
     for k in allColonies.keys {
     if i == index { return k }
     i += 1
     }
     return nil
     }*/
     
     func getColonyTupleForIndex(index: Int) -> (name: String, colony: Colony)? {
     var i = 0
     for (k,v) in allColonies {
     if i == index { return (k,v) }
     i += 1
     }
     return nil
     }
     */
}
