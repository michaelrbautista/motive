//
//  API.swift
//  Motive
//
//  Created by Michael Bautista on 4/30/25.
//

struct FeedResponse: Codable {
    var quotes: [QuoteResponse]
}

struct EmergencyResponse: Codable {
    var content: String
}

struct QuoteResponse: Codable {
    var quote: String
    var source: String
}
