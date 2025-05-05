//
//  HomeViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI
import WidgetKit

final class HomeViewModel: ObservableObject {
    
    @Published var topic = "Random"
    
    @Published var isLoading = false
    
    @Published var quote = ""
    @Published var source = ""
    @Published var image = Data()
    
    @Published var hasGenerated = false
    
    @Published var returnedError = false
    @Published var errorMessage = ""
    
    // MARK: Generate new quote
    @MainActor
    public func generateNewQuote() async {
        self.isLoading = true
        
        var randomTopic = "Self improvement"
        
        if self.topic == "Random" {
            randomTopic = [
                "Self improvement",
                "Entrepreneurship",
                "Sports"
            ].randomElement() ?? "Self improvement"
        }
        
        OpenAIService.shared.getQuoteMain(
            topic: self.topic == "Random" ? randomTopic : self.topic
        ) { response in
            self.quote = response.quote
            self.source = response.source
            
            self.hasGenerated = true
            self.isLoading = false
        }
    }
}
