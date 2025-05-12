//
//  OnboardingViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
@Observable
final class OnboardingViewModel {
    
    var inspirations = Set<String>()
    var goals = ""
    
    var email = ""
    
    var isValidEmail = false
    
    var isPersonalizingGeneral = true
    var isPersonalizingQuotes = true
    
    var returnedError = false
    var errorMessage = ""
    
}
