//
//  EmergencyViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 5/13/25.
//

import SwiftUI

@Observable
final class EmergencyViewModel {
    
    var content = ""
    
    var isLoading = true
    
    // MARK: Get emergency quote
    public func getQuote() {
        APIService.shared.getEmergencyQuote { response in
            self.content = response.content
            self.isLoading = false
        }
    }
    
}
