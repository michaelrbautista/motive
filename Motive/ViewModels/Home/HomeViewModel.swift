//
//  HomeViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class HomeViewModel {
    
    var quotes = [QuoteResponse]()
    
    var currentIndex = 0
    
    // MARK: Get more quotes
    public func getMoreQuotes() {
        APIService.shared.getQuotesForFeed { response in
            self.quotes.append(contentsOf: response.quotes)
        }
    }
}
