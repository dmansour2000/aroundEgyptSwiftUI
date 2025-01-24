//
//  WelcomeViewModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import Foundation
import Combine

class RecommendedExperiencesViewModel: ObservableObject{
    var cancellable = Set<AnyCancellable>()
    
    @Published var experiences: RecommendedExperiencesModel?
    let service: RecommendedExperiencesService
    
    init(service: RecommendedExperiencesService){
        self.service = service
        getServerData()
    }
    
    func getServerData() {
            service.getExperiencesData(url: Constants.recommendedExperiences)
                .sink{ completion in switch completion {
                case .failure(let error): print("error", error)
                case .finished:
                    print("completion")
                }} receiveValue: { [weak self] response in
                    self?.experiences = response
                    
                }
                .store(in: &cancellable )
  
    }
    
}
