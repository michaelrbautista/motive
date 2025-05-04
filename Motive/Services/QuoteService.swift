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
    public static var quote = ""
    public static var source = ""
    
    init() {
        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
        
        if let existingQuote = userDefaults?.value(forKey: "dailyQuote") as? String, let existingSource = userDefaults?.value(forKey: "dailySource") as? String {
            QuoteService.quote = existingQuote
            QuoteService.source = existingSource
        }
    }
    
    // MARK: Create and quote
    public func createAndSaveQuote(topic: String) {
        OpenAIService.shared.getQuoteMain(topic: topic) { response in
            self.saveQuote(quote: response.quote, source: response.source)
        }
    }
    
    // MARK: Save quote
    public func saveQuote(quote: String, source: String) {
        // Save to UserDefaults
        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
        userDefaults?.set(quote, forKey: "dailyQuote")
        userDefaults?.set(source, forKey: "dailySource")
        
        QuoteService.quote = quote
        QuoteService.source = source
        
        // Set last quote date
        UserDefaults.standard.set(Date.now, forKey: "lastQuoteDate")
        
        // Update widget timeline
        WidgetCenter.shared.reloadAllTimelines()
        
        // Schedule next quote
        BackgroundService.shared.scheduleAppRefresh()
    }
}
