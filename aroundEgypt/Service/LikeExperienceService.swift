//
//  LikeExperienceModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation
import Combine

class LikeExperienceService {
    
    var cancellable = Set<AnyCancellable>()
    
    func postExperienceData(url: String) -> Future<LikeExperienceModel, ExperiencesError> {
        return Future { promise in
            
            
            guard let url = URL(string: url) else {
                return promise(.failure(.networkError(description: "Invalid URL")))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Perform the request
            URLSession.shared.dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) in
                    guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                        throw ExperiencesError.networkError(description: "Invalid response")
                    }
                    return data
                }
                .decode(type: LikeExperienceModel.self, decoder: JSONDecoder())
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case _ as DecodingError:
                            promise(.failure(.parsingError(description: "Failed to parse data")))
                        default:
                            promise(.failure(.networkError(description: "Unable to get data")))
                        }
                    }
                } receiveValue: { response in
                    return promise(.success(response))
                }
                .store(in: &self.cancellable)
        }
    }
}
