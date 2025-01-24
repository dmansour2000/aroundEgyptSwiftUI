//
//  MockSingleExperienceService.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation
import Combine
@testable import aroundEgypt

// Mock Service to simulate responses
class MockSingleExperienceService: SingleExperienceService {

    // Override the getExperiencesData function to return mock data
    override func getExperiencesData(url: String) -> Future<SingleExperienceModel, ExperiencesError> {
        
        // Create a Future that will resolve with mocked data
        return Future { promise in
            
            // Mocked data: You can replace this with real test data
            let mockExperience = SingleExperienceModel(meta: Meta(code: 0, errors: []),
                                                       data: Datum(id: "test123", title: "Mock Experience", coverPhoto: "https://example.com/image.jpg", description: "This is a mock description for unit testing.", viewsNo: 337, likesNo: 53, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "Mock City", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: Era(id: "", value: "", createdAt: "", updatedAt: ""), era: Era(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation(type: "", coordinates: []), openingHours: OpeningHours(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours(sunday: Day(day: "", time: Friday.the07001600), monday: Day(day: "", time: Friday.the07001600), tuesday: Day(day: "", time: Friday.the07001600), wednesday: Day(day: "", time: Friday.the07001600), thursday: Day(day: "", time: Friday.the07001600), friday: Day(day: "", time: Friday.the07001600), saturday: Day(day: "", time: Friday.the07001600)), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false), pagination: Pagination()
            )
            
            // Call the promise with the mocked success data
            promise(.success(mockExperience))
            
            
        }
    }
}
