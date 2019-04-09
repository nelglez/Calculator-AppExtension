//
//  Calculator.swift
//  RPN
//
//  Created by Spencer Curtis on 3/6/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import Foundation

/* Access Control

 - Open
 - Public
 
 - Internal
 - Private
*/

// I want this to be accessible to anything importing the framework.
public struct Calculator {
    
    public init() { }
    
    // Push a number onto the stack
    
    public mutating func push(_ number: Double) {
        stack.push(number)
    }
    
    public enum Operator {
        case add
        case subtract
        case multiply
        case divide
    }
    
    // "push" an operator onto the stack, or perform the operation.
    
    public mutating func push(operator: Operator) {
        
        let element1 = stack.pop() ?? 0.0
        let element2 = stack.pop() ?? 0.0
        
        let result: Double
        
        switch `operator` {
        case .add:
            result = element1 + element2
        case .subtract:
            result = element1 - element2
        case .multiply:
            result = element1 * element2
        case .divide:
            result = element1 / element2
        }
    
        stack.push(result)
    }
    
    // View the top value in the stack
    
    public var topValue: Double? {
        return stack.peek()
    }
    
    // Clear the stack
    
    public mutating func clearStack() {
        stack = []
    }
    
    private var stack: Stack<Double> = [0.0, 0.0]
}
