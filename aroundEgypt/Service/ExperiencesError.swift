//
//  WelcomeError.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 23/01/2025.
//

import Foundation

enum ExperiencesError: Error{
    case networkError(description: String)
    case parsingError(description: String)
}
