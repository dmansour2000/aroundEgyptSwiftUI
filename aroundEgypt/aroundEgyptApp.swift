//
//  aroundEgyptApp.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import SwiftUI

@main
struct aroundEgyptApp: App {
  

    var body: some Scene {
        WindowGroup {
       
            WelcomeView(recommendedViewModel: RecommendedExperiencesViewModel(service: RecommendedExperiencesService()), mostRecentViewModel: MostRecentExperiencesViewModel(service: MostRecentExperiencesService()), searchViewModel: SearchExperiencesViewModel(service: SearchExperiencesService(), searchText: "Luxor"))
               
        }
    }
}
