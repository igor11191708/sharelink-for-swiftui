//
//  ShareLinkButtonTests.swift
//
//
//  Created by Igor  on 03.07.24.
//

import XCTest
import SwiftUI
@testable import sharelink_for_swiftui

final class ShareLinkButtonTests: XCTestCase {

    func testShareText() {
        let shareLinkButton = ShareLinkButton(item: "Hello, world!") {
            Text("Share Text")
        }
        XCTAssertNotNil(shareLinkButton)
    }

    func testShareURL() {
        let url = URL(string: "https://example.com")!
        let shareLinkButton = ShareLinkButton(item: url) {
            Text("Share URL")
        }
        XCTAssertNotNil(shareLinkButton)
    }

    func testShareImage() {
        let image = UIImage(systemName: "photo")!
        let shareLinkButton = ShareLinkButton(item: image) {
            Image(systemName: "photo")
        }
        XCTAssertNotNil(shareLinkButton)
    }

    func testCustomActivity() {
        let customActivity = UIActivity()
        let shareLinkButton = ShareLinkButton(item: "Custom Activity", applicationActivities: [customActivity]) {
            Text("Share Custom Activity")
        }
        XCTAssertNotNil(shareLinkButton)
    }
    
    static var allTests = [
        ("testShareText", testShareText),
        ("testShareURL", testShareURL),
        ("testShareImage", testShareImage),
        ("testCustomActivity", testCustomActivity),
    ]
}
