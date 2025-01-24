//
//  WelcomeViewUITests.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import XCTest

final class WelcomeViewUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    func testWelcomeHeader() {
        XCTAssertTrue(app.staticTexts["Welcome!"].exists, "The Welcome header should be visible")
        XCTAssertTrue(app.staticTexts["Now you can explore any experience in 360 degrees and get all the details about it all in one place."].exists, "The subtitle should be visible")
    }
    
    func testRecommendedSection() {
        let recommendedSection = app.staticTexts["Recommended Experiences"]
        XCTAssertTrue(recommendedSection.exists, "The Recommended Experiences section should be visible")
        
        let firstRecommendedItem = app.scrollViews.firstMatch.staticTexts.firstMatch
        XCTAssertTrue(firstRecommendedItem.exists, "At least one recommended experience should be visible")
    }
    
    func testMostRecentSection() {
        let mostRecentSection = app.staticTexts["Most Recent"]
        XCTAssertTrue(mostRecentSection.exists, "The Most Recent section should be visible")
        
        let firstMostRecentItem = app.scrollViews.firstMatch.staticTexts.firstMatch
        XCTAssertTrue(firstMostRecentItem.exists, "At least one most recent experience should be visible")
    }
    
    func testSearchFunctionality() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.exists, "The search field should be visible")
        
        searchField.tap()
        searchField.typeText("Luxor")
        app.keyboards.buttons["Search"].tap()
        
        let firstSearchResult = app.scrollViews.firstMatch.staticTexts.firstMatch
        XCTAssertTrue(firstSearchResult.exists, "At least one search result should appear after entering a valid search term")
    }
    
    func testNavigationToDetailView() {
        let firstRecommendedItem = app.scrollViews.firstMatch.staticTexts.firstMatch
        XCTAssertTrue(firstRecommendedItem.exists, "At least one recommended experience should be visible")
        
        firstRecommendedItem.tap()
        XCTAssertTrue(app.staticTexts["Description"].exists, "Navigating to an experience should display the DetailView with a description")
    }
}
