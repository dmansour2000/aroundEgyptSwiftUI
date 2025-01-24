//
//  Constants.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import Foundation

struct Constants {
    
    static let baseURL = "https://aroundegypt.34ml.com"
    
    static let recommendedExperiences = "/api/v2/experiences?filter[recommended]=true"
    
    static let recentExperiences = "/api/v2/experiences"
    
    static let searchExperiences = "/api/v2/experiences?filter[title]="
    
    static let singleExperience = "/api/v2/experiences/"
    
    static let likeSingleExperience = "/like"
    
}
