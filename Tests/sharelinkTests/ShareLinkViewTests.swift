//
//  ShareLinkViewTests.swift
//
//
//  Created by Igor  on 19.08.24.
//

import XCTest
@testable import sharelink_for_swiftui

class ShareLinkViewTests: XCTestCase {

    /// A sample string to share.
    let sampleString = "This is a sample string to share."
    
    /// A sample URL to share.
    let sampleURL = URL(string: "https://www.apple.com")!
    
    func testInitializationWithData() {
        let data = [sampleURL]
        let shareLinkView = ShareLinkView(data: data)
        XCTAssertEqual(shareLinkView.data.count, 1)
    }

    func testInitializationWithApplicationActivities() {
        let data = [sampleString]
        let activity = UIActivity()
        let shareLinkView = ShareLinkView(data: data, applicationActivities: [activity])
        XCTAssertEqual(shareLinkView.applicationActivities?.count, 1)
    }

    func testInitializationWithExcludedActivityTypes() {
        let data = [sampleString]
        let excludedTypes: [UIActivity.ActivityType] = [.postToFacebook, .postToTwitter]
        let shareLinkView = ShareLinkView(data: data, excludedActivityTypes: excludedTypes)
        XCTAssertEqual(shareLinkView.excludedActivityTypes?.count, 2)
    }
}
