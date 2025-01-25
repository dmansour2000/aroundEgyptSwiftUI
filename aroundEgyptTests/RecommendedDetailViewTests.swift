//
//  DetailViewTests.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import aroundEgypt

// Extend the view for testing
extension RecommendedDetailView: Inspectable {}

final class RecommendedDetailViewTests: XCTestCase {

    func testViewDisplaysCorrectTitle() throws {
        // Arrange
        let viewModel = LikeExperienceViewModel(service: MockLikeExperienceService(), id: "123")
        let testItem = Datum(id: "123", title: "Test Title", coverPhoto: "", description: "Test Description", viewsNo: 10, likesNo: 5, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "Test City", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: Era(id: "", value: "", createdAt: "", updatedAt: ""), era: Era(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation(type: "", coordinates: []), openingHours: OpeningHours(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours(sunday: Day(day: "", time: Friday.the07001600), monday: Day(day: "", time: Friday.the07001600), tuesday: Day(day: "", time: Friday.the07001600), wednesday: Day(day: "", time: Friday.the07001600), thursday: Day(day: "", time: Friday.the07001600), friday: Day(day: "", time: Friday.the07001600), saturday: Day(day: "", time: Friday.the07001600)), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false)
        let view = RecommendedDetailView(likeviewModel: viewModel, item: testItem)

        // Act
        let displayedTitle = try view.inspect().find(text: "Test Title").string()

        // Assert
        XCTAssertEqual(displayedTitle, "Test Title")
    }

    
}


