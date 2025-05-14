//
//  APIResponse.swift
//  Motive
//
//  Created by Michael Bautista on 4/30/25.
//

struct EmergencyResponse: Codable {
    var content: String
}

struct APIResponse: Codable {
    var quote: String
    var source: String
}
