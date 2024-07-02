//
//  HalfSheetActivityController.swift
//  
//
//  Created by Igor Shel on 29.10.2023.
//

import UIKit

/// A custom `UIActivityViewController` subclass that customizes the presentation of the activity sheet.
class ActivitySheetController: UIActivityViewController {

    deinit {
        #if DEBUG
        print("deinit ActivitySheetController")
        #endif
    }
    
    /// Called just before the view controller's view is added to a view hierarchy.
    ///
    /// - Parameter animated: If true, the view is being added to the window using an animation.
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 15.0, *) {
            /// Presentation for iOS 15 and later
            if let presentation = sheetPresentationController {
                presentation.detents = [.medium(), .large()]
                presentation.prefersGrabberVisible = true
            }
        } else {
            /// Support for iOS 14
            modalPresentationStyle = .overFullScreen
        }
    }
}
