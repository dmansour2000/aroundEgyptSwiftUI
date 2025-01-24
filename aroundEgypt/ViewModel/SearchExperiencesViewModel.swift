//
//  SearchViewModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import Foundation
import Combine

class SearchExperiencesViewModel: ObservableObject{
    var cancellable = Set<AnyCancellable>()
    
    @Published var searchExperiences: SearchExperiencesModel?
    let service: SearchExperiencesService
    
    init(service: SearchExperiencesService, searchText: String){
        self.service = service
        getServerData(searchText: searchText)
    }
    
    func getServerData(searchText: String) {
        service.getExperiencesData(url: Constants.searchExperiences + searchText)
            .sink{ completion in switch completion {
            case .failure(let error): print("error", error)
            case .finished:
                print("completion")
            }} receiveValue: { [weak self] response in
                self?.searchExperiences = response
                
            }
            .store(in: &cancellable )
  
    }
    
}
