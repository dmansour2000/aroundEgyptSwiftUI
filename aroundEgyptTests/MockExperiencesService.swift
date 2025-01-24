//
//  MockExperiencesService.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation
import Combine
@testable import aroundEgypt

class MockExperiencesService: ExperiencesService {
    var mockResponse: ExperiencesModel?
    var mockError: ExperiencesError?

    override func getExperiencesData(url: String) -> Future<ExperiencesModel, ExperiencesError> {
        return Future { promise in
            if let mockError = self.mockError {
                // Simulate a failure
                promise(.failure(mockError))
            } else if let mockResponse = self.mockResponse {
                // Simulate a successful response
                promise(.success(mockResponse))
            } else {
                // Simulate an unexpected error
                promise(.failure(.networkError(description: "No mock data provided")))
            }
        }
    }
}
