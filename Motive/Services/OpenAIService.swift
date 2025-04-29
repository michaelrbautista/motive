//
//  OpenAIService.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI

final class OpenAIService: ObservableObject {
    
    public static let shared = OpenAIService()
    
    // MARK: Get quote
    public func getQuote(topic: String) -> String {
        return "Circumstances don't make the man. They merely reveal him to himself."
    }
    
}
