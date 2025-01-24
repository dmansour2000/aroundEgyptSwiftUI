//
//  MockLikeExperienceService.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation
import Combine
@testable import aroundEgypt

// Mock Service to simulate responses for LikeExperienceService
class MockLikeExperienceService: LikeExperienceService {

    // Override the postExperienceData function to return mock data
    override func postExperienceData(url: String) -> Future<LikeExperienceModel, ExperiencesError> {
        
        // Create a Future that will resolve with mocked data
        return Future { promise in
            
            // Mocked response: You can customize this with test data for LikeExperienceModel
            let mockLikeExperience = LikeExperienceModel(meta: Meta(code: 0, errors: []), data: 57, pagination: Pagination()
            )
            
            // Call the promise with the mocked success data
            promise(.success(mockLikeExperience))
            
            
        }
    }
}
