//
//  SingleExperienceViewModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation
import Combine

class SingleExperienceViewModel: ObservableObject{
    var cancellable = Set<AnyCancellable>()
    
    @Published var experience: SingleExperienceModel?
    let service: SingleExperienceService
    
    init(service: SingleExperienceService, id: String){
        self.service = service
        getServerData(id: id)
    }
    
    func getServerData(id: String) {
        Task{
            service.getExperiencesData(url: Constants.singleExperience + id)
                .sink{ completion in switch completion {
                case .failure(let error): print("error", error)
                case .finished:
                    print("completion")
                }} receiveValue: { [weak self] response in
                    self?.experience = response
                    
                }
                .store(in: &cancellable )
        }
  
    }
    
}
