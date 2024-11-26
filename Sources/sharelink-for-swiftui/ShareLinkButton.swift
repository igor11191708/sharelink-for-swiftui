//
//  ShareLinkButton.swift
//
//
//  Created by Igor Shelopaev on 29.10.2023.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

/// A SwiftUI view that provides a button to share data using `UIActivityViewController`.
@available(iOS 14.0, *)
@MainActor
public struct ShareLinkButton<Label: View>: View {
    
    /// State to control the presentation of the share sheet.
    @State private var isPresented: Bool = false
    
    /// The data to be shared. It can include items like text, images, URLs, etc.
    private let data: [Any]
    
    /// A closure that provides the label for the button.
    private let label: () -> Label
    
    /// Optional custom activities to include in the share sheet.
    private let applicationActivities: [UIActivity]?
    
    /// Optional activity types to exclude from the share sheet.
    private let excludedActivityTypes: [UIActivity.ActivityType]?

    /// Initializer for `Transportable` items using the builder internally.
    ///
    /// - Parameters:
    ///   - item: The item to be shared, conforming to the `Transportable` protocol.
    ///   - icon: An optional icon for the item.
    ///   - title: An optional title for the item.
    ///   - printAction: A flag to determine if the print action should be included.
    ///   - applicationActivities: Optional custom activities to include in the share sheet.
    ///   - excludedActivityTypes: Optional activity types to exclude from the share sheet.
    ///   - label: A closure that provides the label for the button.
    public init<T: Transportable>(
        item: T,
        icon: UIImage? = nil,
        title: String? = nil,
        printAction: Bool = true,
        applicationActivities: [UIActivity]? = nil,
        excludedActivityTypes: [UIActivity.ActivityType]? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        let builder = TransportableItemBuilder(item: item)
            .setIcon(icon)
            .setTitle(title)
            .setPrintAction(printAction)
        
        self.data = builder.build()
        self.applicationActivities = applicationActivities
        self.excludedActivityTypes = excludedActivityTypes
        self.label = label
    }
    
    /// Initializer for `UIActivityItemSource` items.
    ///
    /// - Parameters:
    ///   - itemSource: The item source to be shared.
    ///   - applicationActivities: Optional custom activities to include in the share sheet.
    ///   - excludedActivityTypes: Optional activity types to exclude from the share sheet.
    ///   - label: A closure that provides the label for the button.
    public init(
        itemSource: UIActivityItemSource,
        applicationActivities: [UIActivity]? = nil,
        excludedActivityTypes: [UIActivity.ActivityType]? = nil,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.data = [itemSource]
        self.applicationActivities = applicationActivities
        self.excludedActivityTypes = excludedActivityTypes
        self.label = label
    }

    /// The content and behavior of the view.
    public var body: some View {
        Button(action: {
            isPresented = true
        }, label: label)
        .sheet(isPresented: $isPresented) {
            ShareLinkView(
                data: data,
                applicationActivities: applicationActivities,
                excludedActivityTypes: excludedActivityTypes
            )
        }
    }
}
