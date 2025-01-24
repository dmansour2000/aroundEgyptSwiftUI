//
//  SearchExperienceModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchExperiencesModel = try? JSONDecoder().decode(SearchExperiencesModel.self, from: jsonData)

import Foundation

// MARK: - SearchExperiencesModel
struct SearchExperiencesModel: Codable {
    let meta: Meta
    let data: [Datum3]
    let pagination: Pagination
}

// MARK: - Datum
struct Datum3: Identifiable, Codable {
    let id, title: String
    let coverPhoto: String
    let description: String
    let viewsNo, likesNo, recommended, hasVideo: Int
    let tags: [City]
    let city: City
    let tourHTML: String
    let famousFigure: String
    let period: JSONNull?
    let era: Era3
    let founded, detailedDescription, address: String
    let gmapLocation: GmapLocation3
    let openingHours: OpeningHours3
    let translatedOpeningHours: TranslatedOpeningHours3
    let startingPrice: Int
    let ticketPrices: [TicketPrice3]
    let experienceTips: [JSONAny]
    let isLiked: JSONNull?
    let reviews: [JSONAny]
    let rating, reviewsNo: Int
    let audioURL: String
    let hasAudio: Bool

    enum CodingKeys: String, CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
        case description
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended
        case hasVideo = "has_video"
        case tags, city
        case tourHTML = "tour_html"
        case famousFigure = "famous_figure"
        case period, era, founded
        case detailedDescription = "detailed_description"
        case address
        case gmapLocation = "gmap_location"
        case openingHours = "opening_hours"
        case translatedOpeningHours = "translated_opening_hours"
        case startingPrice = "starting_price"
        case ticketPrices = "ticket_prices"
        case experienceTips = "experience_tips"
        case isLiked = "is_liked"
        case reviews, rating
        case reviewsNo = "reviews_no"
        case audioURL = "audio_url"
        case hasAudio = "has_audio"
    }
}


// MARK: - Era
struct Era3: Codable {
    let id, value, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, value
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - GmapLocation
struct GmapLocation3: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - OpeningHours
struct OpeningHours3: Codable {
    let sunday, monday, tuesday, wednesday: [String]
    let thursday, friday, saturday: [String]
}

// MARK: - TicketPrice
struct TicketPrice3: Codable {
    let type: String
    let price: Int
}

// MARK: - TranslatedOpeningHours
struct TranslatedOpeningHours3: Codable {
    let sunday, monday, tuesday, wednesday: Day3
    let thursday, friday, saturday: Day3
}

// MARK: - Day
struct Day3: Codable {
    let day, time: String
}

