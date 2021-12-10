//
//  Math.swift
//  First Project To DO
//
//  Created by Tim on 26/04/1443 AH.
//

import Foundation

class DivBy0Error : Error {
    
}
class Math {
    func divide(num1: Int, num2: Int)throws -> Int {
        if num2 == 0 {
         let error = DivBy0Error()
            throw error
        }
        return num1/num2
    }
}
