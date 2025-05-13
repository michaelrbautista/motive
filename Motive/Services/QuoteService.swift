//
//  QuoteService.swift
//  Motive
//
//  Created by Michael Bautista on 5/2/25.
//

import SwiftUI
import WidgetKit

final class QuoteService: ObservableObject {
    
    public static let shared = QuoteService()
    
    // MARK: Create new quote
    public func createAndSaveQuote(completion: @escaping ((String, String) -> Void)) {
        OpenAIService.shared.getQuoteMain { response in
            // Save quote
            self.saveQuote(quote: response.quote, source: response.source)
            
            // Generate and save image
            completion(response.quote, response.source)
        }
    }
    
    // MARK: Save quote
    public func saveQuote(quote: String, source: String) {
        // Save to UserDefaults
        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
        userDefaults?.set(quote, forKey: "quote")
        userDefaults?.set(source, forKey: "source")
        
        // Set last quote date
        UserDefaults.standard.set(Date.now, forKey: "lastQuote")
        
        // Update widget timeline
        WidgetCenter.shared.reloadAllTimelines()
        
        // Schedule next quote
        BackgroundService.shared.scheduleAppRefresh()
    }
}
