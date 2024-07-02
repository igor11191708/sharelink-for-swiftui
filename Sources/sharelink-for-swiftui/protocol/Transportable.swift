//
//  Transportable.swift
//
//  Created by Igor on 01.07.24.
//

import UIKit
import CoreLocation

/// Protocol `Transportable` inherits `CustomStringConvertible` for providing textual descriptions of objects.
public protocol Transportable: CustomStringConvertible {}

extension String: Transportable {
    /// The description of a string is the string itself.
    public var description: String { self }
}

extension URL: Transportable {
    /// The description of a URL is its absolute string representation.
    public var description: String { self.absoluteString }
}

extension UIImage: Transportable {
    /// Property to extract the named parameter from the image description.
    var namedParameter: String? {
        /// Define the pattern to match the named parameter.
        let pattern = "named\\(\\w*: (\\w+)\\)"
        
        /// Create a regular expression to match the pattern.
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let nsRange = NSRange(description.startIndex..<description.endIndex, in: description)
            if let match = regex.firstMatch(in: description, options: [], range: nsRange) {
                if let range = Range(match.range(at: 1), in: description) {
                    return String(description[range])
                }
            }
        }
        return nil
    }
}

extension Data: Transportable {
    /// The description of data is its string representation, or "Data object" if conversion fails.
    public var description: String {
        return String(data: self, encoding: .utf8) ?? "Data object"
    }
}

extension NSAttributedString: Transportable {}

extension CLLocation: Transportable {}
