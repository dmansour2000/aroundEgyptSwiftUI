//
//  LikeExperienceViewModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation
import Combine

class LikeExperienceViewModel: ObservableObject{
    var cancellable = Set<AnyCancellable>()
    
    @Published var experience: LikeExperienceModel?
    let service: LikeExperienceService
    
    init(service: LikeExperienceService, id: String){
        self.service = service
        postServerData(id: id)
    }
    
    func postServerData(id: String) {
        Task{
            service.postExperienceData(url: Constants.baseURL + Constants.singleExperience + id + Constants.likeSingleExperience)
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
