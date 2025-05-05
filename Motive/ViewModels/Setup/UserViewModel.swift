//
//  UserViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import Supabase
import SuperwallKit
import HealthKit

@MainActor
class UserViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    @Published var event: AuthChangeEvent? = nil
    @Published var session: Session? = nil
    
    @Published var topics = [String]()
    
    @Published var quote: String? = nil
    @Published var source: String? = nil
    
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
            
            // Get topics from UserDefaults
            if let userTopics = UserDefaults.standard.array(forKey: "topics") as? [String] {
                self.topics = userTopics
            }
            
            // Get quote and source
            let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
            self.quote = userDefaults?.value(forKey: "quote") as? String
            self.source = userDefaults?.value(forKey: "source") as? String
            
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
