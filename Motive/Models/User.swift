//
//  User.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct User: Codable, Identifiable, Hashable {
    var id: String
    var createdAt: String?
    var email: String
    var religion: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email, religion
        case createdAt = "created_at"
    }
}
