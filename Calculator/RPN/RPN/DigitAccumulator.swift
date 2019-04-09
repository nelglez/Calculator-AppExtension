//
//  DigitAccumulator.swift
//  RPN
//
//  Created by Spencer Curtis on 3/6/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import Foundation

public enum DigitAccumulatorError: Error {
    case invalidNumberValue
    case extraDecimalPoint
}


public struct DigitAccumulator {
    
    public init() { } 
    
    public enum Digit: Equatable {
        case decimalPoint
        case number(Int)
    }
    
    // There's the chance that something we try to do won't work (i.e. adding two decimals to the same number
    public mutating func add(digit: Digit) throws {
        
        switch digit {
            
        case .number(let value):
            
            // Is the number between 0 and 9?
            if value < 0 || value > 9 {
                throw DigitAccumulatorError.invalidNumberValue
            }
            
        case .decimalPoint:
            
            if digits.contains(.decimalPoint) {
                throw DigitAccumulatorError.extraDecimalPoint
            }
        }
        
        digits.append(digit)
    }
    
    public mutating func clear() {
        digits.removeAll()
    }
    
    // Turn the array of digits into a single (valid) number
    
    public func value() -> Double? {
        
        let string = digits.map { (digit) -> String in
            switch digit {
            case .decimalPoint:
                return "."
                
            case .number(let value):
                return String(value)
            }
        }.joined()
        
        return Double(string)
    }
    
    
    private var digits: [Digit] = []
    
}
