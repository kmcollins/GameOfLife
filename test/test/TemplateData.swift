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
    var templateCells = [Set(), Set(), Set([Coordinate(x:30, y:30), Coordinate(x: 29, y: 29), Coordinate(x: 30, y: 29), Coordinate(x: 31, y: 29)]),
                         Set([Coordinate(x: 6, y: 2), Coordinate(x: 6, y: 3), Coordinate(x: 7, y: 2), Coordinate(x: 7, y: 3), Coordinate(x: 4, y: 14), Coordinate(x: 4, y: 15), Coordinate(x: 5, y: 13), Coordinate(x: 5, y: 17), Coordinate(x: 6, y: 12), Coordinate(x: 6, y: 18), Coordinate(x: 7, y: 12), Coordinate(x: 7, y: 16), Coordinate(x: 7, y: 18), Coordinate(x: 7, y: 19), Coordinate(x: 8, y: 12), Coordinate(x: 8, y: 18), Coordinate(x: 9, y: 13), Coordinate(x: 9, y: 17), Coordinate(x: 10, y: 14), Coordinate(x: 10, y: 15), Coordinate(x: 4, y: 22), Coordinate(x: 4, y: 23), Coordinate(x: 5, y: 22), Coordinate(x: 5, y: 23), Coordinate(x: 6, y: 22), Coordinate(x: 6, y: 23), Coordinate(x: 3, y: 24), Coordinate(x: 3, y: 26), Coordinate(x: 2, y: 26), Coordinate(x: 7, y: 24), Coordinate(x: 7, y: 26), Coordinate(x: 8, y: 26), Coordinate(x: 4, y: 36), Coordinate(x: 4, y: 37), Coordinate(x: 5, y: 36), Coordinate(x: 5, y: 37)])]
    
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