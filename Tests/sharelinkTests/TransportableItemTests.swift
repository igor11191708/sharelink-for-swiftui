import XCTest
import UIKit
import LinkPresentation
@testable import sharelink_for_swiftui

final class TransportableItemTests: XCTestCase {

    // Sample data for testing
    let sampleString = "This is a sample string to share."
    let sampleURL = URL(string: "https://www.apple.com")!

    func testInitializationWithTitleAndIcon() {
        let icon = UIImage(systemName: "star")
        let title = "Example Title"
        let transportableItem = TransportableItem(item: sampleString, icon: icon, title: title)

        XCTAssertEqual(transportableItem.getTitle, title)
        XCTAssertEqual(transportableItem.getIcon, icon)
    }

    func testInitializationWithoutTitleAndIcon() {
        let transportableItem = TransportableItem(item: sampleURL)

        XCTAssertNil(transportableItem.getTitle)
        XCTAssertNil(transportableItem.getIcon)
    }
}
