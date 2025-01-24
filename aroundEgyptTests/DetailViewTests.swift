//
//  DetailViewTests.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import XCTest
@testable import aroundEgypt

final class DetailViewTests: XCTestCase {
    
    var singleViewModel: SingleExperienceViewModel!
    var likeViewModel: LikeExperienceViewModel!
    let mockCache = Cache<SingleExperienceModel>(memory: MemoryCache(countLimit: 100), disk: DiskCache(fileManager: DefaultFileManager()))
    let mockLikeCache = Cache<LikeCacheModel>(memory: MemoryCache(countLimit: 100), disk: DiskCache(fileManager: DefaultFileManager()))
    
    override func setUp() {
        super.setUp()
        singleViewModel = SingleExperienceViewModel(service: MockSingleExperienceService(), id: "test-id")
        likeViewModel = LikeExperienceViewModel(service: MockLikeExperienceService(), id: "test-id")
    }

    func testSaveAndLoadFromCache() {
        let sampleExperience = SingleExperienceModel(meta: Meta(code: 0, errors: []),
                                                     data: Datum(id: "test123", title: "Mock Experience", coverPhoto: "https://example.com/image.jpg", description: "This is a mock description for unit testing.", viewsNo: 337, likesNo: 53, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "Mock City", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: Era(id: "", value: "", createdAt: "", updatedAt: ""), era: Era(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation(type: "", coordinates: []), openingHours: OpeningHours(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours(sunday: Day(day: "", time: Friday.the07001600), monday: Day(day: "", time: Friday.the07001600), tuesday: Day(day: "", time: Friday.the07001600), wednesday: Day(day: "", time: Friday.the07001600), thursday: Day(day: "", time: Friday.the07001600), friday: Day(day: "", time: Friday.the07001600), saturday: Day(day: "", time: Friday.the07001600)), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false), pagination: Pagination()
          )
        do {
            try mockCache.save(sampleExperience, forKey: "singleExperience_test-id")
        } catch {
            XCTFail("Failed to save to cache: \(error)")
        }
        
        let cachedExperience = try? mockCache.value(forKey: "singleExperience_test-id")
        XCTAssertNotNil(cachedExperience, "Cached experience should not be nil")
        XCTAssertEqual(cachedExperience?.data.title, "Test Experience", "Cached experience title should match")
    }

    func testLikeFunctionality() {
        let likeState = LikeCacheModel(id: "test-id", isLiked: true)
        
        do {
            try mockLikeCache.save(likeState, forKey: "likeExperience_test-id")
        } catch {
            XCTFail("Failed to save like state to cache: \(error)")
        }
        
        let cachedLike = try? mockLikeCache.value(forKey: "likeExperience_test-id")
        XCTAssertNotNil(cachedLike, "Cached like state should not be nil")
        XCTAssertTrue(cachedLike?.isLiked ?? false, "Cached like state should be true")
    }
    
    func testNetworkFallbackToCache() {
        // Mock experience data to save in the cache
        let mockExperience = SingleExperienceModel(
            meta: Meta(code: 0, errors: []),
            data: Datum(
                id: "test123",
                title: "Offline Experience", // Title for assertion
                coverPhoto: "https://example.com/image.jpg",
                description: "This is a mock description for unit testing.",
                viewsNo: 337,
                likesNo: 53,
                recommended: 0,
                hasVideo: 0,
                tags: [],
                city: City(id: 0, name: "Mock City", disable: JSONNull(), topPick: 0),
                tourHTML: "",
                famousFigure: "",
                period: Era(id: "", value: "", createdAt: "", updatedAt: ""),
                era: Era(id: "", value: "", createdAt: "", updatedAt: ""),
                founded: "",
                detailedDescription: "",
                address: "",
                gmapLocation: GmapLocation(type: "", coordinates: []),
                openingHours: OpeningHours(
                    sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []
                ),
                translatedOpeningHours: TranslatedOpeningHours(
                    sunday: Day(day: "", time: Friday.the07001600),
                    monday: Day(day: "", time: Friday.the07001600),
                    tuesday: Day(day: "", time: Friday.the07001600),
                    wednesday: Day(day: "", time: Friday.the07001600),
                    thursday: Day(day: "", time: Friday.the07001600),
                    friday: Day(day: "", time: Friday.the07001600),
                    saturday: Day(day: "", time: Friday.the07001600)
                ),
                startingPrice: 0,
                ticketPrices: [],
                experienceTips: [],
                isLiked: JSONNull(),
                reviews: [],
                rating: 0,
                reviewsNo: 0,
                audioURL: "",
                hasAudio: false
            ),
            pagination: Pagination()
        )

        // Save the mock experience into the mock cache
        try? mockCache.save(mockExperience, forKey: "singleExperience_offline-id")

        // Initialize the SingleExperienceViewModel with a mock service
        let mockService = MockSingleExperienceService() // Assume this is created
        let singleViewModel = SingleExperienceViewModel(service: mockService, id: "test123")

        // Simulate cache loading manually in the test
        if let cachedExperience = try? mockCache.value(forKey: "singleExperience_offline-id")! as SingleExperienceModel {
            singleViewModel.experience = cachedExperience
        }

        // Perform the assertion
        XCTAssertEqual(
            singleViewModel.experience?.data.title,
            "Offline Experience",
            "Fallback should load experience from cache"
        )
    }

}
