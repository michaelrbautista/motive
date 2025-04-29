//
//  HomeViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var topic = ""
    
    @Published var isGenerating = false
    
    @Published var returnedError = false
    @Published var errorMessage = ""
    
}
