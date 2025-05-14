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
    var sendReminder = true
    var checkInTime: Date = {
        var components = DateComponents()
        components.hour = 20
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    var email = ""
    
    var isValidEmail = false
    
    var isPersonalizing = true
    
    var code = ""
    var isLoading = false
    
    var returnedError = false
    var errorMessage = ""
    
    // MARK: Sign in
    public func signIn(completion: @escaping ((String, String) -> Void)) async {
        self.isLoading = true
        
        do {
            let session = try await SupabaseService.shared.supabase.auth.verifyOTP(email: email, token: code, type: .email)
            
            let currentUserId = session.user.id.description
            
            // Get user from db
            let user = try await UserService.shared.getUser(uid: currentUserId)
            
            UserService.currentUser = user
            
            // Get image
            let image = try await StorageService.shared.getImage()
            StorageService.shared.saveImage(image: image ?? Data())
            
            // Create quote
            QuoteService.shared.createAndSaveQuote { quote, source in
                completion(quote, source)
            }
        } catch {
            self.returnedError = true
            self.errorMessage = errorMessage
            self.isLoading = false
        }
    }
    
    // MARK: Create account
    public func createAccount(completion: @escaping ((String, String) -> Void)) async {
        self.isLoading = true
        
        do {
            let session = try await SupabaseService.shared.supabase.auth.verifyOTP(email: email, token: code, type: .email)
            
            // Set user to logged in and redirect
            let currentUserId = session.user.id.description
            
            let newUser = User(
                id: currentUserId,
                email: email
            )
            
            // Create user row
            let user = try await UserService.shared.createUser(user: newUser)
            
            UserService.currentUser = user
            
            // Schedule notification
            if sendReminder {
                NotificationService.shared.scheduleNotification(date: checkInTime)
                UserDefaults.standard.set(checkInTime, forKey: "checkInTime")
            }
            
            // Create quote
            QuoteService.shared.createAndSaveQuote { quote, source in
                completion(quote, source)
            }
        } catch {
            print(error)
            self.returnedError = true
            self.errorMessage = "Couldn't create your account. Please try again later."
            self.isLoading = false
        }
    }
}
