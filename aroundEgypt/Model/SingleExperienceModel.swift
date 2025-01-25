//
//  SingleExperienceModel.swift
//  aroundEgypt
//
//  Created by Dina Mansour  on 24/01/2025.
//

import Foundation

// MARK: - SingleExperienceModel
struct SingleExperienceModel: Codable {
    let meta: Meta4
    let data: DataClass
    let pagination: Pagination4
}

// MARK: - DataClass
struct DataClass: Identifiable, Codable {
    let id, title: String
    let coverPhoto: String
    let description: String
    let viewsNo, likesNo, recommended, hasVideo: Int
    let tags: [City2]
    let city: City2
    let tours: [JSONAny2]
    let tourURL: String
    let tourHTML: String
    let tourXML: String
    let famousFigure: String
    let period: JSONNull2?
    let era: Era4
    let founded, detailedDescription, address: String
    let gmapLocation: GmapLocation4
    let openingHours: OpeningHours4
    let translatedOpeningHours: TranslatedOpeningHours4
    let startingPrice: Int
    let ticketPrices: [TicketPrice4]
    let experienceTips, reviews: [JSONAny2]
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
        case tags, city, tours
        case tourURL = "tour_url"
        case tourHTML = "tour_html"
        case tourXML = "tour_xml"
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
        case reviews, rating
        case reviewsNo = "reviews_no"
        case audioURL = "audio_url"
        case hasAudio = "has_audio"
    }
}

// MARK: - City
struct City2: Codable {
    let id: Int
    let name: String
    let disable: JSONNull2?
    let topPick: Int

    enum CodingKeys: String, CodingKey {
        case id, name, disable
        case topPick = "top_pick"
    }
}

// MARK: - Era
struct Era4: Codable {
    let id, value, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, value
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - GmapLocation
struct GmapLocation4: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - OpeningHours
struct OpeningHours4: Codable {
    let sunday, monday, tuesday, wednesday: [String]
    let thursday, friday, saturday: [String]
}

// MARK: - TicketPrice
struct TicketPrice4: Codable {
    let type: String
    let price: Int
}

// MARK: - TranslatedOpeningHours
struct TranslatedOpeningHours4: Codable {
    let sunday, monday, tuesday, wednesday: Day4
    let thursday, friday, saturday: Day4
}

// MARK: - Day
struct Day4: Codable {
    let day, time: String
}

// MARK: - Meta
struct Meta4: Codable {
    let code: Int
    let errors: [JSONAny2]
}

// MARK: - Pagination
struct Pagination4: Codable {
}

// MARK: - Encode/decode helpers

class JSONNull2: Codable, Hashable {

    public static func == (lhs: JSONNull2, rhs: JSONNull2) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey2: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny2: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}

