//
//  ShareLinkView.swift
//
//  Created by Igor Shelopaev on 29.10.2023.
//

#if canImport(SwiftUI)
import SwiftUI
#endif

#if canImport(UIKit)
import UIKit
#endif

#if canImport(CoreLocation)
import CoreLocation
#endif

/// A SwiftUI view that wraps a `UIActivityViewController` to share data.
struct ShareLinkView: UIViewControllerRepresentable {
    
    /// The data to be shared. It can include items like text, images, URLs, etc.
    let data: [Any]
    
    /// Optional custom activities to include in the share sheet.
    let applicationActivities: [UIActivity]?
    
    /// Optional activity types to exclude from the share sheet.
    let excludedActivityTypes: [UIActivity.ActivityType]?

    /// Initializes a new `ShareLinkView`.
    ///
    /// - Parameters:
    ///   - data: The data to be shared.
    ///   - applicationActivities: Optional custom activities to include in the share sheet.
    ///   - excludedActivityTypes: Optional activity types to exclude from the share sheet.
    init(
        data: [Any],
        applicationActivities: [UIActivity]? = nil,
        excludedActivityTypes: [UIActivity.ActivityType]? = nil
    ) {
        self.data = data
        self.applicationActivities = applicationActivities
        self.excludedActivityTypes = excludedActivityTypes
    }
    
    /// Creates the view controller to be presented.
    ///
    /// - Parameter context: The context in which the view is being created.
    /// - Returns: An `ActivitySheetController` configured with the provided data, application activities, and excluded activity types.
    public func makeUIViewController(context: Context) -> ActivitySheetController {
        let controller = ActivitySheetController(activityItems: data, applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.modalPresentationStyle = .popover
        return controller
    }
    
    /// Updates the view controller with new data.
    ///
    /// - Parameters:
    ///   - uiViewController: The view controller to be updated.
    ///   - context: The context in which the view is being updated.
    public func updateUIViewController(_ uiViewController: ActivitySheetController, context: Context) {}
}
