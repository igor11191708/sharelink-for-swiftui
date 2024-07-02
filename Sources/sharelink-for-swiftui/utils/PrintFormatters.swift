//
//  PrintFormatters.swift
//
//  Created by Igor on 01.07.24.
//

import UIKit

/// Creates a `UISimpleTextPrintFormatter` for printing a string with a title.
///
/// - Parameters:
///   - value: The string to be printed.
///   - title: The title to be displayed above the string.
/// - Returns: A `UISimpleTextPrintFormatter` configured with the provided string and title.
func printStringFormatter(_ value: String, _ title: String) -> UISimpleTextPrintFormatter {
    // Create attributed string for title using the builder
    let titleStr = AttributedStringBuilder()
        .setFont(fontSize: 50, weight: .bold)
        .setForegroundColor(.black)
        .build(with: title + "\n") // Adding a newline after the title
    
    let result = NSMutableAttributedString()
    result.append(titleStr)
    
    // Only add value if it is not equal to title
    if value != title {
        let valueStr = AttributedStringBuilder()
            .setFont(fontSize: 27)
            .setForegroundColor(.black)
            .build(with: value)
        result.append(valueStr)
    }
    
    return UISimpleTextPrintFormatter(attributedText: result)
}

/// Creates a `UIViewPrintFormatter` for printing an image.
///
/// - Parameter value: The image to be printed.
/// - Returns: A `UIViewPrintFormatter` configured with the provided image.
func printImageFormatter(_ value: UIImage) -> UIViewPrintFormatter {
    return UIImageView(image: value).viewPrintFormatter()
}
