//
//  TransportableItemBuilder.swift
//
//  Created by Igor on 01.07.24.
//

import UIKit
import SwiftUI
import CoreLocation

/// Final builder class for creating transportable items with additional attributes for sharing.
final class TransportableItemBuilder<T: Transportable> {
    
    /// The item to be shared, conforming to the `Transportable` protocol.
    private var item: T
    
    /// An optional title for the item.
    private var title: String?
    
    /// An optional icon for the item.
    private var icon: UIImage?
    
    /// A flag to determine if the print action should be included.
    private var printAction: Bool = true
    
    /// Initializes a new builder with the given item.
    ///
    /// - Parameter item: The item to be shared, conforming to the `Transportable` protocol.
    init(item: T) {
        self.item = item
    }
    
    /// Sets the title for the item.
    ///
    /// - Parameter title: An optional title for the item.
    /// - Returns: The builder instance with the updated title.
    public func setTitle(_ title: String?) -> TransportableItemBuilder {
        self.title = title
        return self
    }
    
    /// Sets the icon for the item.
    ///
    /// - Parameter icon: An optional icon for the item.
    /// - Returns: The builder instance with the updated icon.
    public func setIcon(_ icon: UIImage?) -> TransportableItemBuilder {
        self.icon = icon
        return self
    }
    
    /// Sets the print action flag for the item.
    ///
    /// - Parameter printAction: A flag to determine if the print action should be included.
    /// - Returns: The builder instance with the updated print action flag.
    public func setPrintAction(_ printAction: Bool) -> TransportableItemBuilder {
        self.printAction = printAction
        return self
    }
    
    /// Builds the transportable items array.
    ///
    /// - Returns: An array of transportable items with the set attributes.
    public func build() -> [Any] {
        return createTransportableItem()
            + createPrintFormatterIfNeeded()
    }
    
    /// Creates the transportable item based on its type.
    ///
    /// - Returns: An array containing the transportable item.
    private func createTransportableItem() -> [Any] {
        let resolvedTitle = resolveTitle(item: item, title: title)
        
        switch item {
            case let item as String:
                return [TransportableItem(item: item, icon: icon, title: resolvedTitle)]
            case let item as URL:
                return [TransportableItem(item: item.absoluteString, icon: icon, title: resolvedTitle)]
            case let item as UIImage:
                return [TransportableItem(item: item, icon: icon, title: resolvedTitle)]
            case let item as Data:
                return [TransportableItem(item: item, icon: icon, title: resolvedTitle)]
            case let item as NSAttributedString:
                return [TransportableItem(item: item.string, icon: icon, title: resolvedTitle)]
            case let item as CLLocation:
                let locationURLString = "https://maps.apple.com/?ll=\(item.coordinate.latitude),\(item.coordinate.longitude)"
                return [TransportableItem(item: locationURLString, icon: icon, title: resolvedTitle)]
            default:
                return [TransportableItem(item: item.description, icon: icon, title: resolvedTitle)]
        }
    }
    
    /// Creates the print formatter if the print action is enabled.
    ///
    /// - Returns: An array containing the print formatter if needed, otherwise an empty array.
    private func createPrintFormatterIfNeeded() -> [Any] {
        guard printAction else {
            return []
        }
        
        let resolvedTitle = resolveTitle(item: item, title: title)
        
        if let imageItem = item as? UIImage {
            return [printImageFormatter(imageItem)]
        } else {
            return [createStringFormatter(item: item, resolvedTitle: resolvedTitle)]
        }
    }
}

/// Resolves the title for the item if it is not provided.
///
/// - Parameters:
///   - item: The item to be shared, conforming to the `Transportable` protocol.
///   - title: An optional title for the item.
/// - Returns: A resolved title based on the item's type or the provided title.
fileprivate func resolveTitle<T: Transportable>(item: T, title: String?) -> String {
    if let title = title {
        return title
    }
    
    switch item {
    case let item as String:
        return item
    case let item as URL:
        return item.absoluteString
    case let item as UIImage:
        return item.namedParameter ?? "Untitled"
    case let item as Data:
        return item.description
    case let item as NSAttributedString:
        return item.string
    case let item as CLLocation:
        return "\(item.coordinate.latitude), \(item.coordinate.longitude)"
    default:
        return item.description
    }
}

/// Creates a `UISimpleTextPrintFormatter` for the item.
///
/// - Parameters:
///   - item: The item to be printed, conforming to the `Transportable` protocol.
///   - resolvedTitle: The resolved title for the item.
/// - Returns: A `UISimpleTextPrintFormatter` configured with the provided item and title.
fileprivate func createStringFormatter<T: Transportable>(item: T, resolvedTitle: String) -> UISimpleTextPrintFormatter {
    switch item {
    case let item as String:
        return printStringFormatter(item, resolvedTitle)
    case let item as URL:
        return printStringFormatter(item.absoluteString, resolvedTitle)
    case let item as Data:
        return printStringFormatter(item.description, resolvedTitle)
    case let item as NSAttributedString:
        return printStringFormatter(item.string, resolvedTitle)
    case let item as CLLocation:
        let locationURLString = "https://maps.apple.com/?ll=\(item.coordinate.latitude),\(item.coordinate.longitude)"
        return printStringFormatter(locationURLString, resolvedTitle)
    default:
        return printStringFormatter(item.description, resolvedTitle)
    }
}
