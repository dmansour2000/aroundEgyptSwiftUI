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

    func testRecommendedDetailViewUIElementsExist() throws {
        let app = XCUIApplication()

        // Navigate to the RecommendedDetailView (Assume proper navigation for your app structure)
        // Example: app.buttons["Recommended Details"].tap()

        // Check for Title
        XCTAssertTrue(app.staticTexts["Test Title"].exists, "The title is not displayed correctly.")

        // Check for City Name
        XCTAssertTrue(app.staticTexts["Test City, Egypt"].exists, "The city name is not displayed correctly.")

        // Check for Heart Button
        XCTAssertTrue(app.buttons["heart"].exists, "The like button is not displayed.")

        // Check for Views Count
        XCTAssertTrue(app.staticTexts["10"].exists, "The views count is not displayed.")
    }

    func testLikeButtonToggleUI() throws {
        let app = XCUIApplication()

        // Navigate to the RecommendedDetailView (Assume proper navigation for your app structure)
        // Example: app.buttons["Recommended Details"].tap()

        let likeButton = app.buttons["heart"]
        XCTAssertTrue(likeButton.exists, "The like button is missing.")

        // Tap the Like Button
        likeButton.tap()

        // Verify the Button Changes State (e.g., turns to heart.fill)
        XCTAssertTrue(app.buttons["heart.fill"].exists, "The like button did not toggle to the filled state.")
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
