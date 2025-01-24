//
//  MostRecentExperiencesViewModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import Foundation
import Combine

class MostRecentExperiencesViewModel: ObservableObject{
    var cancellable = Set<AnyCancellable>()
    
    @Published var experiences: MostRecentExperiencesModel?
    let service: MostRecentExperiencesService
    
    init(service: MostRecentExperiencesService){
        self.service = service
        getServerData()
    }
    
    func getServerData() {
            service.getExperiencesData(url: Constants.recentExperiences)
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
