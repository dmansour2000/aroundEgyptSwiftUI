//
//  DetailViewUITests.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import XCTest

final class DetailViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testDetailViewHeaderAndDescription() {
        app.launchArguments.append("--ui-testing-detail")
        app.launchEnvironment["TEST_EXPERIENCE_ID"] = "test-id"
        
        let headerTitle = app.staticTexts["Test Experience"]
        XCTAssertTrue(headerTitle.exists, "The experience title should be displayed")
        
        let descriptionText = app.staticTexts["Test Description"]
        XCTAssertTrue(descriptionText.exists, "The experience description should be visible")
    }
    
    func testLikeButtonToggle() {
        let likeButton = app.buttons["heart"]
        XCTAssertTrue(likeButton.exists, "The like button should be visible")
        
        likeButton.tap()
        XCTAssertTrue(app.buttons["heart.fill"].exists, "The like button should toggle to filled state")
    }
    
    func testSaveImageOnTap() {
        let imageElement = app.images.firstMatch
        XCTAssertTrue(imageElement.exists, "The cover image should be visible")
        
        imageElement.tap() // Assume tapping saves the image
        let saveConfirmation = app.staticTexts["Image saved to photo album"]
        XCTAssertTrue(saveConfirmation.exists, "A confirmation message should appear after saving the image")
    }
    
    func testOfflineModeFallback() {
        app.launchArguments.append("--ui-testing-offline")
        
        let offlineTitle = app.staticTexts["Offline Experience"]
        XCTAssertTrue(offlineTitle.exists, "The title from the cache should be displayed in offline mode")
    }
}
