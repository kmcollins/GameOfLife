//
//  TemplateData.swift
//  GameOfLife
//
//  Created by Katie Collins on 12/3/16.
//  Copyright © 2016 CollinsInnovation. All rights reserved.
//

import Foundation

class TemplateData {
    var templates = ["Current", "Blank", "Basic", "Glider Gun"]
    var templateCells = [Set(), Set(), Set([Coordinate(x:30, y:30), Coordinate(x: 29, y: 29), Coordinate(x: 30, y: 29), Coordinate(x: 31, y: 29)]), Set()]
    
    func setCurrentCells(cells: Set<Coordinate>){
        templateCells[0] = cells
    }
    
    func addTemplate(name: String, cells: Set<Coordinate>) {
        templates.append(name)
        templateCells.append(cells)
    }
    
    func getCount() -> Int {
        return templates.count
    }
    
    func nameForRow(row: Int) -> String {
        return templates[row]
    }
    
    func cellsForRow(row: Int) -> Set<Coordinate> {
        return templateCells[row]
    }
}