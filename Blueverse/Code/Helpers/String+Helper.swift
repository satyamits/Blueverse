//
//  String+Helper.swift
//  Blueverse
//
//  Created by Vaibhav Parmar on 01/04/23.
//  Copyright © 2023 Nickelfox. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func condensingWhitespace() -> String {
        return self.components(separatedBy: .whitespacesAndNewlines)
                   .filter { !$0.isEmpty }
                   .joined(separator: " ")
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat,
                font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat,
               font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude,
                                    height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font:
                                                            font], context: nil)

        return ceil(boundingBox.width)
    }
}

extension String {
    
    func attributedStringWithColor(_ strings: [String],
                                   color: UIColor,
                                   characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: characterSpacing,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        
        return attributedString
    }
}

extension String {
    
    func stringAt(_ index: Int) -> String? {
        guard let element = Array(self)[safe: index] else { return nil }
        return String(element)
    }
    
    func base64ToImage() -> UIImage? {
        if let url = URL(string: self), let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    
    var removingAllWhitespaces: Self {
        filter { !$0.isWhitespace }
    }
    
    mutating func removeAllWhitespaces() {
        removeAll(where: \.isWhitespace)
    }
    
}

extension String {
    func capitalizingFirstLetterWithSmallCase() -> String {
        let first = String(self.prefix(1)).capitalized
        let other = String(self.dropFirst()).lowercased()
        return first + other
    }
}

extension String {
    
    subscript(_ ith: Int) -> String {
        let idx1 = index(startIndex, offsetBy: ith)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }

    subscript (range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[start ..< end])
    }

    subscript (range: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: range.upperBound - range.lowerBound)
        return String(self[startIndex...endIndex])
    }
    
}
