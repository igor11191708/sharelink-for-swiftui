//
//  AttributedStringBuilderTests.swift
//  
//
//  Created by Igor  on 19.08.24.
//


import XCTest
@testable import sharelink_for_swiftui

final class AttributedStringBuilderTests: XCTestCase {

    func testSetFont() {
        let builder = AttributedStringBuilder()
        let result = builder.setFont(fontSize: 18, weight: .bold)
                            .build(with: "Test String")

        let attributes = result.attributes(at: 0, effectiveRange: nil)
        let font = attributes[.font] as? UIFont
        XCTAssertEqual(font, UIFont.systemFont(ofSize: 18, weight: .bold))
    }

    func testSetForegroundColor() {
        let builder = AttributedStringBuilder()
        let result = builder.setForegroundColor(.red)
                            .build(with: "Test String")

        let attributes = result.attributes(at: 0, effectiveRange: nil)
        let color = attributes[.foregroundColor] as? UIColor
        XCTAssertEqual(color, UIColor.red)
    }

    func testBuildWithDefaultAttributes() {
        let builder = AttributedStringBuilder()
        let result = builder.build(with: "Default String")

        let attributes = result.attributes(at: 0, effectiveRange: nil)
        let font = attributes[.font] as? UIFont
        let color = attributes[.foregroundColor] as? UIColor

        XCTAssertEqual(font, UIFont.systemFont(ofSize: 12))
        XCTAssertEqual(color, UIColor.black)
    }

    func testBuildWithCustomAttributes() {
        let builder = AttributedStringBuilder()
        let result = builder.setFont(fontSize: 16, weight: .medium)
                            .setForegroundColor(.blue)
                            .build(with: "Custom String")

        let attributes = result.attributes(at: 0, effectiveRange: nil)
        let font = attributes[.font] as? UIFont
        let color = attributes[.foregroundColor] as? UIColor

        XCTAssertEqual(font, UIFont.systemFont(ofSize: 16, weight: .medium))
        XCTAssertEqual(color, UIColor.blue)
    }
}
