//
//  Stack.swift
//  RPN
//
//  Created by Spencer Curtis on 3/6/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import Foundation

struct Stack<Element>: ExpressibleByArrayLiteral {
    
    typealias ArrayLiteralElement = Element
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self.elements = elements
    }
    
    // Add things to the stack
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    // Remove them from the stack
    mutating func pop() -> Element? {
        return elements.popLast()
    }
    
    // Know what is at the top of the stack
    func peek() -> Element? {
        return elements.last
    }
    
    // private(set) allows other types to read the value of elements, but not write to it.
    private(set) var elements: [Element]
}
