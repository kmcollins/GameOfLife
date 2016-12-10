//
//  Coordinate.swift
//  GameOfLife
//
//  Created by Katie Collins on 9/14/16.
//  Copyright © 2016 CollinsInnovation. All rights reserved.
//

import Foundation

struct Coordinate: Hashable{
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
        
    var hashValue: Int {
        return 1000 * x + y
    }
    
}

extension Coordinate: Equatable {}

func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.hashValue == rhs.hashValue
}









