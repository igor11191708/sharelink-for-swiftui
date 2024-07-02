import UIKit
import SwiftUI
import LinkPresentation
import CoreLocation
import Contacts

public struct ShareLinkButton<Label: View>: View {
    
    @State private var isPresented: Bool = false
    
    private let data: [Any]
    
    private let label: () -> Label
    
    private let applicationActivities: [UIActivity]?
    
    private let excludedActivityTypes: [UIActivity.ActivityType]?

    // Initializer for Transportable items using the builder internally
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
    
    // Initializer for UIActivityItemSource items
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
