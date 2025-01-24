//
//  MostRecentExperiencesModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let experiencesModel = try? JSONDecoder().decode(ExperiencesModel.self, from: jsonData)

import Foundation

// MARK: - ExperiencesModel
struct MostRecentExperiencesModel: Codable {
    let meta: Meta
    let data: [Datum2]
    let pagination: Pagination
}

// MARK: - Datum
struct Datum2: Identifiable, Codable {
    let id, title: String
    let coverPhoto: String
    let description: String
    let viewsNo, likesNo, recommended, hasVideo: Int
    let tags: [City]
    let city: City
    let tourHTML: String
    let famousFigure: String
    let period, era: Era2?
    let founded, detailedDescription, address: String
    let gmapLocation: GmapLocation2
    let openingHours: OpeningHours2
    let translatedOpeningHours: TranslatedOpeningHours2
    let startingPrice: Int?
    let ticketPrices: [TicketPrice2]
    let experienceTips: [JSONAny]
    let isLiked: JSONNull?
    let reviews: [Review2]
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
struct Era2: Codable {
    let id, value, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, value
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - GmapLocation
struct GmapLocation2: Codable {
    let type: TypeEnum
    let coordinates: [Double]
}

enum TypeEnum: String, Codable {
    case point = "Point"
}

// MARK: - OpeningHours
struct OpeningHours2: Codable {
    let sunday, monday, tuesday, wednesday: [String]?
    let thursday, friday, saturday: [String]?
}

// MARK: - Review
struct Review2: Codable {
    let id, experience, name: String
    let rating: Int
    let comment, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, experience, name, rating, comment
        case createdAt = "created_at"
    }
}

// MARK: - TicketPrice
struct TicketPrice2: Codable {
    let type: String
    let price: Int
}

// MARK: - TranslatedOpeningHours
struct TranslatedOpeningHours2: Codable {
    let sunday, monday, tuesday, wednesday: FridayClass2?
    let thursday, friday, saturday: FridayClass2?
}

// MARK: - FridayClass
struct FridayClass2: Codable {
    let day: DayEnum2
    let time: String
}

enum DayEnum2: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}

// MARK: - Meta
struct Meta2: Codable {
    let code: Int
    let errors: [JSONAny]
}

// MARK: - Pagination
struct Pagination2: Codable {
}
