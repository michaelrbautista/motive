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
    var reminderTime: Date = {
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
    
    // MARK: Schedule notification
    public func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Daily Check In"
        content.body = "It's time to check in."
        content.sound = .default

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: reminderTime)
        let minute = calendar.component(.minute, from: reminderTime)
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Daily notification scheduled for \(hour):\(minute)")
            }
        }
    }
    
    // MARK: Sign in
    public func signIn(completion: @escaping ((String, String) -> Void)) async {
        self.isLoading = true
        
        do {
            let session = try await SupabaseService.shared.supabase.auth.verifyOTP(email: email, token: code, type: .email)
            
            let currentUserId = session.user.id.description
            
            // Get user from db
            let user = try await UserService.shared.getUser(uid: currentUserId)
            
            UserService.currentUser = user
            
            UserDefaults.standard.set(reminderTime, forKey: "reminderTime")
            
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
                scheduleNotification()
                UserDefaults.standard.set(reminderTime, forKey: "reminderTime")
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
