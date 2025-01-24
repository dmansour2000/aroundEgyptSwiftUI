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
        let mostrecentmockService = MockMostRecentExperiencesService()
        let mockmostrecentExperience = MostRecentExperiencesModel(meta: Meta(code: 0, errors: []),
                                              data: [Datum2(id: "", title: "", coverPhoto: "https://picsum.photos/id/27/200/300", description: "Description ...", viewsNo: 337, likesNo: 57, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: Era2(id: "", value: "", createdAt: "", updatedAt: ""), era: Era2(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation2(type: .point, coordinates: []), openingHours: OpeningHours2(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours2(sunday: FridayClass2(day: .friday, time: ""), monday: FridayClass2(day: .friday, time: ""), tuesday: FridayClass2(day: .friday, time: ""), wednesday: FridayClass2(day: .friday, time: ""), thursday: FridayClass2(day: .friday, time: ""), friday: FridayClass2(day: .friday, time: ""), saturday: FridayClass2(day: .friday, time: "")), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false)], pagination: Pagination())
        mostrecentmockService.mockResponse = mockmostrecentExperience
        
        let recommendedmockService = MockRecommendedExperiencesService()
        let mockrecommendedExperience = RecommendedExperiencesModel(meta: Meta(code: 0, errors: []),
                                              data: [Datum(id: "7351979e-7951-4aad-876f-49d5027438bf", title: "Test", coverPhoto: "https://picsum.photos/id/27/200/300", description: "test", viewsNo: 53, likesNo: 337, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: Era(id: "", value: "", createdAt: "", updatedAt: ""), era: Era(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "address", gmapLocation: GmapLocation(type: "", coordinates: [0.0]), openingHours: OpeningHours(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours(sunday: Day(day: "", time: Friday.the07001600), monday: Day(day: "", time: Friday.the07001600), tuesday: Day(day: "", time: Friday.the07001600), wednesday: Day(day: "", time: Friday.the07001600), thursday: Day(day: "", time: Friday.the07001600), friday: Day(day: "", time: Friday.the07001600), saturday: Day(day: "", time: Friday.the07001600)), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: true)], pagination: Pagination())
        recommendedmockService.mockResponse = mockrecommendedExperience
        
        let searchmockService = MockSearchExperiencesService()
        let mocksearchExperience = SearchExperiencesModel(meta: Meta(code: 0, errors: []),
                                              data: [Datum3(id: "", title: "Test", coverPhoto: "https://picsum.photos/id/27/200/300", description: "Description ....", viewsNo: 67, likesNo: 335, recommended: 0, hasVideo: 0, tags: [], city: City(id: 0, name: "", disable: JSONNull(), topPick: 0), tourHTML: "", famousFigure: "", period: JSONNull(), era: Era3(id: "", value: "", createdAt: "", updatedAt: ""), founded: "", detailedDescription: "", address: "", gmapLocation: GmapLocation3(type: "", coordinates: []), openingHours: OpeningHours3(sunday: [], monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: []), translatedOpeningHours: TranslatedOpeningHours3(sunday: Day3(day: "", time: ""), monday: Day3(day: "", time: ""), tuesday: Day3(day: "", time: ""), wednesday: Day3(day: "", time: ""), thursday: Day3(day: "", time: ""), friday: Day3(day: "", time: ""), saturday: Day3(day: "", time: "")), startingPrice: 0, ticketPrices: [], experienceTips: [], isLiked: JSONNull(), reviews: [], rating: 0, reviewsNo: 0, audioURL: "", hasAudio: false)], pagination: Pagination())
        searchmockService.mockResponse = mocksearchExperience
     
        recommendedViewModel = RecommendedExperiencesViewModel(service: MockRecommendedExperiencesService())
        mostRecentViewModel = MostRecentExperiencesViewModel(service:  mostrecentmockService)
        searchViewModel = SearchExperiencesViewModel(service: searchmockService, searchText: "")
    }

    func testLoadFromCache() {
        let cache = Cache<RecommendedExperiencesModel>(memory: MemoryCache(countLimit: 100), disk: DiskCache(fileManager: DefaultFileManager()))
        let sampleData = RecommendedExperiencesModel(meta: Meta(code: 0, errors: []),
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
