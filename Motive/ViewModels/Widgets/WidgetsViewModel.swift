//
//  WidgetsViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI
import WidgetKit

@Observable
final class WidgetsViewModel {
    
    var quoteIsLoading = false
    var imageIsLoading = false
    
    var originalQuote = ""
    var originalSource = ""
    var originalImage = Data()
    
    var newQuote = ""
    var newSource = ""
    var newImage = Data()
    
    var hasGeneratedQuote = false
    var hasGeneratedImage = false
    
    var returnedError = false
    var errorMessage = ""
    
    // MARK: Get new image
    @MainActor
    public func getNewImage() {
        self.imageIsLoading = true
        
        Task {
            let newImage = try await StorageService.shared.getImage()
            
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
        
        // Get quote
        OpenAIService.shared.getQuoteMain { response in
            self.newQuote = response.quote
            self.newSource = response.source
            
            self.hasGeneratedQuote = true
            self.quoteIsLoading = false
        }
    }
}
