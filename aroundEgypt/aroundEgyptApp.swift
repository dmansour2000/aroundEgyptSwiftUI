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
       
            WelcomeView(recommendedViewModel: RecommendedExperiencesViewModel(service: ExperiencesService()), mostRecentViewModel: MostRecentExperiencesViewModel(service: ExperiencesService()), searchViewModel: SearchExperiencesViewModel(service: ExperiencesService(), searchText: "Luxor"))
               
        }
    }
}
