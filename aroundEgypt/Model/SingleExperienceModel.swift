//
//  SingleExperienceModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation

// MARK: - ExperiencesModel
struct SingleExperienceModel: Codable {
    let meta: Meta
    let data: Datum
    let pagination: Pagination
}
