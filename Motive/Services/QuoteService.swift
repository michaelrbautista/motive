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
    public func createAndSaveQuote(topic: String, completion: @escaping ((String, String, Data) -> Void)) {
        OpenAIService.shared.getQuoteMain(topic: topic) { response in
            // Save quote
            self.saveQuote(quote: response.quote, source: response.source)
            
            Task {
                // Get new image
                let imageData = try await StorageService.shared.getImage(topic: topic)
                
                // Save image data to UserDefaults
                let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
                userDefaults?.set(imageData, forKey: "image")
                
                completion(response.quote, response.source, imageData ?? Data())
            }
        }
    }
    
    // MARK: Save quote
    public func saveQuote(quote: String, source: String) {
        // Save to UserDefaults
        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
        userDefaults?.set(quote, forKey: "quote")
        userDefaults?.set(source, forKey: "source")
        
        // Set last quote date
        UserDefaults.standard.set(quote, forKey: "lastQuote")
        
        // Update widget timeline
        WidgetCenter.shared.reloadAllTimelines()
        
        // Schedule next quote
        BackgroundService.shared.scheduleAppRefresh()
    }
}
