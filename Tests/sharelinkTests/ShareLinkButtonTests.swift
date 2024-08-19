//
//  ShareLinkButtonTests.swift
//
//
//  Created by Igor Shelopaev on 03.07.24.
//

import XCTest
import SwiftUI
@testable import sharelink_for_swiftui


final class ShareLinkButtonTests: XCTestCase {

    @MainActor func testShareText() {
        let shareLinkButton = ShareLinkButton(item: "Hello, world!") {
            Text("Share Text")
        }
        XCTAssertNotNil(shareLinkButton)
    }

    @MainActor func testShareURL() {
        let url = URL(string: "https://example.com")!
        let shareLinkButton = ShareLinkButton(item: url) {
            Text("Share URL")
        }
        XCTAssertNotNil(shareLinkButton)
    }

    @MainActor func testShareImage() {
        let image = UIImage(systemName: "photo")!
        let shareLinkButton = ShareLinkButton(item: image) {
            Image(systemName: "photo")
        }
        XCTAssertNotNil(shareLinkButton)
    }

    @MainActor func testCustomActivity() {
        let customActivity = UIActivity()
        let shareLinkButton = ShareLinkButton(item: "Custom Activity", applicationActivities: [customActivity]) {
            Text("Share Custom Activity")
        }
        XCTAssertNotNil(shareLinkButton)
    }

}
