//
//  WidgetsViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI
import WidgetKit

final class WidgetsViewModel: ObservableObject {
    
    @Published var quoteTopic = "Random"
    @Published var imageTopic = "Random"
    
    @Published var quoteIsLoading = false
    @Published var imageIsLoading = false
    
    @Published var originalQuote = ""
    @Published var originalSource = ""
    @Published var originalImage = Data()
    
    @Published var newQuote = ""
    @Published var newSource = ""
    @Published var newImage = Data()
    
    @Published var hasGeneratedQuote = false
    @Published var hasGeneratedImage = false
    
    @Published var returnedError = false
    @Published var errorMessage = ""
    
    // MARK: Get new image
    @MainActor
    public func getNewImage() {
        self.imageIsLoading = true
        
        var randomTopic = "Self improvement"
        
        if self.quoteTopic == "Random" {
            randomTopic = [
                "Self improvement",
                "Entrepreneurship",
                "Sports"
            ].randomElement() ?? "Self improvement"
        }
        
        Task {
            let newImage = try await StorageService.shared.getImage(topic: self.quoteTopic == "Random" ? randomTopic : self.quoteTopic)
            
            if let image = newImage {
                self.newImage = image
            }
            
            self.hasGeneratedImage = true
            self.imageIsLoading = false
        }
    }
    
    // MARK: Generate new quote
    @MainActor
    public func generateNewQuote() async {
        self.quoteIsLoading = true
        
        var randomTopic = "Self improvement"
        
        if self.quoteTopic == "Random" {
            randomTopic = [
                "Self improvement",
                "Entrepreneurship",
                "Sports"
            ].randomElement() ?? "Self improvement"
        }
        
        // Get quote
        OpenAIService.shared.getQuoteMain(
            topic: self.quoteTopic == "Random" ? randomTopic : self.quoteTopic
        ) { response in
            self.newQuote = response.quote
            self.newSource = response.source
            
            self.hasGeneratedQuote = true
            self.quoteIsLoading = false
        }
    }
}
