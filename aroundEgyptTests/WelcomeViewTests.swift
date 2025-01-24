//
//  WelcomeViewTests.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import XCTest
import Network
@testable import aroundEgypt

final class WelcomeViewTests: XCTestCase {
    
    var recommendedViewModel: RecommendedExperiencesViewModel!
    var mostRecentViewModel: MostRecentExperiencesViewModel!
    var searchViewModel: SearchExperiencesViewModel!
    
    override func setUp() {
        super.setUp()
        let mockService = MockExperiencesService()
        let mockExperience = ExperiencesModel(meta: Meta(code: 0, errors: []),
                                              data: [Datum(id: "test123", title: "Mock Experience", coverPhoto: "https://example.com/image.jpg", description: "This is a mock description for unit testing.", viewsNo: 337, likesNo: 53, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "Mock City", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: Era(id: "", value: "", createdAt: "", updatedAt: ""), era: Era(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation(type: "", coordinates: []), openingHours: OpeningHours(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours(sunday: Day(day: "", time: Friday.the07001600), monday: Day(day: "", time: Friday.the07001600), tuesday: Day(day: "", time: Friday.the07001600), wednesday: Day(day: "", time: Friday.the07001600), thursday: Day(day: "", time: Friday.the07001600), friday: Day(day: "", time: Friday.the07001600), saturday: Day(day: "", time: Friday.the07001600)), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false)], pagination: Pagination())
    mockService.mockResponse = mockExperience
     
        recommendedViewModel = RecommendedExperiencesViewModel(service: mockService)
        mostRecentViewModel = MostRecentExperiencesViewModel(service: mockService)
        searchViewModel = SearchExperiencesViewModel(service: mockService, searchText: "")
    }

    func testLoadFromCache() {
        let cache = Cache<ExperiencesModel>(memory: MemoryCache(countLimit: 100), disk: DiskCache(fileManager: DefaultFileManager()))
        let sampleData = ExperiencesModel(meta: Meta(code: 0, errors: []),
                                         data: [Datum(id: "test123", title: "Mock Experience", coverPhoto: "https://example.com/image.jpg", description: "This is a mock description for unit testing.", viewsNo: 337, likesNo: 53, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "Mock City", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: Era(id: "", value: "", createdAt: "", updatedAt: ""), era: Era(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation(type: "", coordinates: []), openingHours: OpeningHours(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours(sunday: Day(day: "", time: Friday.the07001600), monday: Day(day: "", time: Friday.the07001600), tuesday: Day(day: "", time: Friday.the07001600), wednesday: Day(day: "", time: Friday.the07001600), thursday: Day(day: "", time: Friday.the07001600), friday: Day(day: "", time: Friday.the07001600), saturday: Day(day: "", time: Friday.the07001600)), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false)], pagination: Pagination()
)
        try? cache.save(sampleData, forKey: "recommended")
        
        if let cachedObject = try? cache.value(forKey: "recommended") {
            XCTAssertEqual(cachedObject.data.count, 1, "Cache should contain one experience")
            XCTAssertEqual(cachedObject.data.first?.title, "Test Experience", "Cached experience title should match")
        } else {
            XCTFail("Cache retrieval failed")
        }
    }
    
    func testNetworkMonitoring() {
        let monitor = NWPathMonitor()
        let expectation = self.expectation(description: "Wait for network status")
        var isNetworkAvailable = false
        
        monitor.pathUpdateHandler = { path in
            isNetworkAvailable = path.status == .satisfied
            expectation.fulfill()
        }
        
        let queue = DispatchQueue(label: "NetworkMonitorTest")
        monitor.start(queue: queue)
        
        waitForExpectations(timeout: 5) { _ in
            XCTAssertTrue(isNetworkAvailable, "Network should be available during this test")
        }
    }
    
    func testSearchFunctionality() {
        searchViewModel.getServerData(searchText: "Luxor")
        XCTAssertFalse(searchViewModel.searchExperiences?.data.isEmpty ?? true, "Search results should not be empty for a valid search term")
    }
}
