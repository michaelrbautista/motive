//
//  HomeViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

final class HomeViewModel: ObservableObject {
    
    @Published var quote = ""
    @Published var source = ""
    @Published var image = Data()
    
    @Published var entries = [CheckInEntry]()
    
    @Published var isLoading = false
    
    // MARK: Get entries
    public func getEntries() {
        
    }
    
}
