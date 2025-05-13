//
//  UserViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import Supabase
import HealthKit

@MainActor
@Observable
class UserViewModel {
    var isLoggedIn = false
    var isLoading = false
    
    var event: AuthChangeEvent? = nil
    var session: Session? = nil
    
    var quote: String? = nil
    var source: String? = nil
    var image: Data? = nil
    
    init() {
        self.isLoading = true
        
        Task {
            await checkAuth()
        }
    }
    
    // MARK: Check auth
    @MainActor
    public func checkAuth() async {
        self.isLoading = true
        
        do {
            let _ = try await SupabaseService.shared.supabase.auth.session
            
            let authUser = try await SupabaseService.shared.supabase.auth.session.user
            
            // Get user from db
            let user: User = try await SupabaseService.shared.supabase
                .from("users")
                .select()
                .eq("id", value: authUser.id)
                .single()
                .execute()
                .value
            
            UserService.currentUser = user
            
            // Check if user has gotten new quote for the day
            if let lastQuoteDate = UserDefaults.standard.object(forKey: "lastQuote") as? Date {
                print(lastQuoteDate)
                let calendar = Calendar.current
                if !calendar.isDateInToday(lastQuoteDate) {
                    QuoteService.shared.createAndSaveQuote { quote, source in
                        print("New quote created and saved.")
                    }
                }
            }
            
            // Get quote, source, and image
            let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
            self.quote = userDefaults?.value(forKey: "quote") as? String
            self.source = userDefaults?.value(forKey: "source") as? String
            self.image = userDefaults?.value(forKey: "image") as? Data
            
            // Check streak
            let calendar = Calendar.current
            
            let lastEntry = UserDefaults.standard.value(forKey: "lastCheckIn") as? Date
            let now = Date()
            
            if let entry = lastEntry {
                let lastDay = calendar.startOfDay(for: entry)
                let today = calendar.startOfDay(for: now)
                
                if let daysBetween = calendar.dateComponents([.day], from: lastDay, to: today).day {
                    if daysBetween >= 2 {
                        print("Streak lost")
                        UserDefaults.standard.set(0, forKey: "streak")
                    } else {
                        print("Streak still going")
                    }
                }
            } else {
                UserDefaults.standard.set(0, forKey: "streak")
            }
            
            self.isLoggedIn = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isLoading = false
            }
        } catch {
            print(error)
            self.isLoggedIn = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isLoading = false
            }
        }
    }
}
