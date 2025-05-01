//
//  HomeViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var topic = ""
    
    @Published var isLoading = false
    
    @Published var quote = ""
    @Published var person = ""
    
    @Published var returnedError = false
    @Published var errorMessage = ""
    
    // MARK: Generate new quote
    @MainActor
    public func generateNewQuote() {
        self.isLoading = true
        
        OpenAIService.shared.getQuote(topic: self.topic) { response in
            self.quote = response.quote
            self.person = response.person
            
            self.isLoading = false
        }
    }
}
