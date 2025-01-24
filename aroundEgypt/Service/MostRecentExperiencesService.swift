//
//  WelcomeService.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import Foundation
import Combine


class MostRecentExperiencesService {
    
    var cancellable = Set<AnyCancellable>()
    
    func getExperiencesData(url: String) -> Future<MostRecentExperiencesModel, ExperiencesError>{
        
        return Future { promise in
            guard let url = URL(string: Constants.baseURL + url )else{
                return promise(.failure(.networkError(description: "Invalid URL")))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap { (data, response) in
                    guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                        throw ExperiencesError.networkError(description: "Invalid response")
                    }
                    print("Raw JSON Data: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")
                    return data
                }
                .decode(type: MostRecentExperiencesModel.self, decoder: JSONDecoder())
                .sink{ completion in
                    if case let .failure(error) = completion {
                        switch error {
                            
                        case _ as DecodingError:
                            promise(.failure(.parsingError(description: "failed to parse data")))
                        default:
                            promise(.failure(.networkError(description: "not able to get data")))
                        }
                        
                    
                    }
                } receiveValue: { response in
                    return promise(.success(response))
                }
                .store(in: &self.cancellable)
            
            
        }
        
    }
}
