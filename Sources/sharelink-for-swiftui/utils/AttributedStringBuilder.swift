//
//  AttributedStringBuilder.swift
//
//
//  Created by Igor  on 02.07.24.
//

import UIKit

/// Builder class for creating `NSAttributedString` with custom attributes.
final class AttributedStringBuilder {
    
    /// Private variables for attributes
    private var font: UIFont = UIFont.systemFont(ofSize: 12)
    private var foregroundColor: UIColor = .black
    
    /// Sets the font for the attributed string.
    ///
    /// - Parameters:
    ///   - fontSize: The size of the font.
    ///   - weight: The weight of the font.
    /// - Returns: The builder instance with the updated font.
    func setFont(fontSize: CGFloat, weight: UIFont.Weight = .regular) -> AttributedStringBuilder {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        return self
    }
    
    /// Sets the foreground color for the attributed string.
    ///
    /// - Parameter color: The color of the text.
    /// - Returns: The builder instance with the updated color.
    func setForegroundColor(_ color: UIColor) -> AttributedStringBuilder {
        self.foregroundColor = color
        return self
    }
    
    /// Builds the `NSAttributedString` with the provided text.
    ///
    /// - Parameter text: The text to be converted to an attributed string.
    /// - Returns: An `NSAttributedString` with the set attributes.
    func build(with text: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: self.font,
            .foregroundColor: self.foregroundColor
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }
}
