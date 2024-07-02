//
//  TransportableItem.swift
//
//  Created by Igor Shel on 29.10.2023.

import UIKit
import LinkPresentation

/// A class that conforms to `UIActivityItemSource` to provide transportable items for sharing activities.
final class TransportableItem<T: Transportable>: NSObject, UIActivityItemSource {
    /// The item to be shared, conforming to the `Transportable` protocol.
    private let item: T
    
    /// An optional title for the item.
    private let title: String?
    
    /// An optional icon for the item.
    private let icon: UIImage?

    /// Initializes a new transportable item with optional title and icon.
    ///
    /// - Parameters:
    ///   - item: The item to be shared, conforming to the `Transportable` protocol.
    ///   - icon: An optional icon for the item.
    ///   - title: An optional title for the item.
    init(item: T, icon: UIImage? = nil, title: String? = nil) {
        self.item = item
        self.title = title
        self.icon = icon
        super.init()
    }
    
    /// Provides a placeholder item for the activity view controller.
    ///
    /// - Parameter activityViewController: The `UIActivityViewController` requesting the placeholder item.
    /// - Returns: The item to be shared.
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return item
    }

    /// Provides the actual item to be shared for the specified activity type.
    ///
    /// - Parameters:
    ///   - activityViewController: The `UIActivityViewController` requesting the item.
    ///   - activityType: The type of activity requesting the item.
    /// - Returns: The item to be shared.
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return item
    }
    
    /// Provides metadata for the link being shared.
    ///
    /// - Parameter activityViewController: The `UIActivityViewController` requesting the metadata.
    /// - Returns: The `LPLinkMetadata` object containing metadata about the item.
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        
        // Set icon if available
        if let icon = icon {
            metadata.iconProvider = NSItemProvider(object: icon)
        } else if let icon = item as? UIImage {
            metadata.iconProvider = NSItemProvider(object: icon)
        }
        
        // Set image if available
        if let image = item as? UIImage {
            metadata.imageProvider = NSItemProvider(object: image)
        }

        // Set title if available
        if let title = title {
            metadata.title = title
        }

        // Set item URL if the item is a URL
        if let urlString = item as? String, let itemURL = URL(string: urlString) {
            metadata.url = itemURL
        } else if let itemURL = item as? URL {
            metadata.url = itemURL
        }

        return metadata
    }
}
