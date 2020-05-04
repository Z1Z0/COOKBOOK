//
//  UITextField + Ext.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/21/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }
    
    func addPadding(padding: PaddingSpace) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
            
        case .left(let spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
            
        case .right(let spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
            
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = equalPaddingView
            self.leftViewMode = .always
            // right
            self.rightView = equalPaddingView
            self.rightViewMode = .always
        }
    }
}

extension Array {
    mutating func remove(elementsAtIndices indicesToRemove: [Int]) -> [Element] {
        guard !indicesToRemove.isEmpty else {
            return []
        }
        
        // Copy the removed elements in the specified order.
        let removedElements = indicesToRemove.map { self[$0] }
        
        // Sort the indices to remove.
        let indicesToRemove = indicesToRemove.sorted()
        
        // Shift the elements we want to keep to the left.
        var destIndex = indicesToRemove.first!
        var srcIndex = destIndex + 1
        func shiftLeft(untilIndex index: Int) {
            while srcIndex < index {
                self[destIndex] = self[srcIndex]
                destIndex += 1
                srcIndex += 1
            }
            srcIndex += 1
        }
        for removeIndex in indicesToRemove[1...] {
            shiftLeft(untilIndex: removeIndex)
        }
        shiftLeft(untilIndex: self.endIndex)
        
        // Remove the extra elements from the end of the array.
        self.removeLast(indicesToRemove.count)
        
        return removedElements
    }
}
