//
//  DetailViewUITests.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import XCTest
import SwiftUI
import aroundEgypt

final class RecommendedDetailViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    func testImageLoad() throws {
        let app = XCUIApplication()

        // Navigate to the RecommendedDetailView (Assume proper navigation for your app structure)
        // Example: app.buttons["Recommended Details"].tap()

        let imageView = app.images.firstMatch

        // Check if the image view exists and is loaded
        XCTAssertTrue(imageView.exists, "The image view is not displayed.")
    }
}
