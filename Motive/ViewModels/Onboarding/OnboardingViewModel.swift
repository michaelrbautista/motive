//
//  OnboardingViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    @Published var inspirations = Set<String>()
    @Published var goals = ""
    @Published var religion = ""
    
    @Published var email = ""
    
    @Published var isValidEmail = false
    
    @Published var isPersonalizingGeneral = true
    @Published var isPersonalizingQuotes = true
    
    @Published var returnedError = false
    @Published var errorMessage = ""
    
}
